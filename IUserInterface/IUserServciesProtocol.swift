//
//  IUserServciesProtocol.swift
//  IUserInterface
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import ICommon

public protocol IUserServciesProtocol {
    
    func checkTngdUser(
        with phoneNumber: String,
        callback: (Bool?,ITngUserInfoProtocol?,RPCError?) -> Void)
    -> Void
    
}
