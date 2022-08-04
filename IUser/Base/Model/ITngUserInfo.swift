//
//  ITngUserInfo.swift
//  IUser
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import IUserInterface

struct ITngUserInfo {
    var nickName: String
    var phoneNumber: String
}

extension ITngUserInfo: ITngUserInfoProtocol{
    var tngdName: String {
        get {
            return nickName
        }
    }
}
