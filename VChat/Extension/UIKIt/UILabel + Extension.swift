//
//  UILabel + Extension.swift
//  VChat
//
//  Created by Влад Барченков on 07.10.2020.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .systemFont(ofSize: 17, weight: .regular)) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
