//
//  SelfConfiguringCell.swift
//  VChat
//
//  Created by Влад Барченков on 09.10.2020.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
