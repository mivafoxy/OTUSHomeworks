//
//  LabelView.swift
//  OTUSHomeworks
//
//  Created by Илья Малахов on 02.12.2022.
//

import SwiftUI

struct LabelView: UIViewRepresentable {
    @Binding var content: String
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = content
    }
}
