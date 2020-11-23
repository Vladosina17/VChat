//
//  InsertasbleTextField.swift
//  VChat
//
//  Created by Влад Барченков on 12.10.2020.
//

import UIKit

class InsertableTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 44)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        placeholder = "Type Someting"
        font = UIFont.systemFont(ofSize: 17, weight: .regular)
        borderStyle = .none
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        let button = UIButton()
        button.setImage(UIImage(named: "sent2"), for: .normal)
        
        rightView = button
        rightView?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        rightViewMode = .always
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -10
        return rect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
