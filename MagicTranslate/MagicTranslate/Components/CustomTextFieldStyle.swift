//
//  CustomTextField.swift
//  MagicTranslate
//
//  Created by Mariia Chemerys on 05.06.2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    var backgroundColor: Color
    var textColor: Color
    var cornerRadius: CGFloat
    var height: CGFloat
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .foregroundColor(textColor)
            .overlay(
                Rectangle()
                    .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                    .foregroundColor(backgroundColor)
            )
            .frame(height: height)
    }
}
