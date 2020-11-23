//
//  WaitingChatsNavigation.swift
//  VChat
//
//  Created by Влад Барченков on 17.10.2020.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
