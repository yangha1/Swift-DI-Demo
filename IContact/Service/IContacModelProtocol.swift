//
//  IHomieContactProtocol.swift
//  IContact
//
//  Created by Harvey on 2022/8/1.
//

import Foundation

protocol ILocalContactProtocol {
    var name: String {get}
    var phoneNumber: String {get}
}

protocol ITngdContactProtocol {
    var tngdName: String? {get}
}

enum HomieType {
    case localHomie, tngdHomie
}

protocol IHomieContactProtocol : ILocalContactProtocol, ITngdContactProtocol{
    var type: HomieType {get}
}
