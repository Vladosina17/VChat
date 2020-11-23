//
//  AuthNavigatingDelegate.swift
//  VChat
//
//  Created by Влад Барченков on 13.10.2020.
//

import Foundation

protocol AuthNavigatingDelegate: class {
    func toLoginVC()
    func toSignUpVC()
}
