//
//  OneLineTextField.swift
//  VChat
//
//  Created by Влад Барченков on 07.10.2020.
//

import UIKit

class OneLineTextField: UITextField {
    
    convenience init(font: UIFont? = .systemFont(ofSize: 17),
                     isSecure: Bool = false,
                     placeholder: String = "Text"
                     ) {
        self.init()
        self.placeholder = placeholder
        self.font = font
        
        
        if isSecure {
            isSecureTextEntry = true
        }
        
        
        let paddingView = UIView(frame: CGRect(x: 16, y: 0, width: 16, height: 40))
        leftView = paddingView
        leftViewMode = .always
        
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)

    
        self.layer.cornerRadius = 8
        
    }
}
