//
//  IContactModel.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation

struct ILocalContact: ILocalContactProtocol {
    var name: String
    var phoneNumber: String
}

struct IHomieContact: IHomieContactProtocol {
    var name: String
    var phoneNumber: String
    var type: HomieType
    var tngdName: String?
}
