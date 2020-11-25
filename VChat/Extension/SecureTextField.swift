//
//  SecureTextField.swift
//  VChat
//
//  Created by Влад Барченков on 23.10.2020.
//

import UIKit

class SecureTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeholder = ""
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        borderStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        isSecureTextEntry = true
        
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
        
        let button = UIButton()
        let image = UIImage(systemName: "eye.fill")
        button.setImage(image, for: .normal)
        button.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.addTarget(self, action: #selector(isSecure), for: .touchUpInside)
        
        rightView = button
        rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        rightViewMode = .whileEditing
        
        let paddingView = UIView(frame: CGRect(x: 16, y: 0, width: 16, height: 40))
        leftView = paddingView
        leftViewMode = .always
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc private func isSecure() {
        isSecureTextEntry.toggle()
        rightView?.tintColor = isSecureTextEntry ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : .buttonViolet()
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -12
        return rect
    }
    
    convenience init(font: UIFont? = .systemFont(ofSize: 17),
                     placeholder: String = "Text") {
        self.init()
        self.placeholder = placeholder
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
