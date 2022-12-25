//
//  CustomNavigationStack.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 18.12.2022.
//

// MARK: - Кастомный навигейшен стек - 1 балл

import SwiftUI

enum NavigationType {
     case push, pop
}

enum AnimationType {
    case none
    case custom(push: AnyTransition, pop: AnyTransition)
}

enum PopDestination {
    case previous, root
}

struct Screen: Equatable {
    let id: String
    let screenView: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

struct CustomNavigationStack {
    var screens: [Screen] = []
    var top: Screen? { screens.last }
    
    mutating func push(newScreen: Screen) {
        screens.append(newScreen)
    }
    
    mutating func pop() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}

final class NavigationStackViewModel: ObservableObject {
    private let easing: Animation
    var navigationType = NavigationType.push
    @Published var currentScreen: Screen?
    
    var screensStack = CustomNavigationStack() {
        didSet {
            currentScreen = screensStack.top
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push(newView: some View) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, screenView: AnyView(newView))
            screensStack.push(newScreen: screen)
        }
    }
    
    func pop(destination: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch destination {
            case .previous:
                screensStack.pop()
            case .root:
                screensStack.popToRoot()
            }
        }
    }
}

struct NavigationStackView<Content>: View where Content: View {
    private let content: Content
    private let transition: (push: AnyTransition, pop: AnyTransition)
    @ObservedObject private var viewModel: NavigationStackViewModel
    
    init(viewModel: NavigationStackViewModel = NavigationStackViewModel(easing: .easeOut(duration: 0.4)),
         transition: AnimationType,
         @ViewBuilder contentBuilder: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        content = contentBuilder()
        switch transition {
        case .none:
            self.transition = (push: .identity, pop: .identity)
        case .custom(let push, let pop):
            self.transition = (push: push, pop: pop)
        }
    }
    
    var body: some View {
        let isRoot = viewModel.currentScreen == nil
        return ZStack {
            if isRoot {
                content
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            } else {
                viewModel.currentScreen?.screenView
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            }
        }
    }
}
