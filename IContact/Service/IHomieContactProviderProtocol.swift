//
//  IHomieContactProvider.swift
//  IContact
//
//  Created by Harvey on 2022/8/1.
//

import Foundation
import ICommon

enum IHomieContactError: Error {
    case db, data
}

typealias IHomieContactCallBack = (Result<Array<IHomieContactProtocol>,IHomieContactError>) -> Void

protocol IHomieContactProviderProtocol {
    func getLocalHomies(_ callback: IHomieContactCallBack) -> Void
    func getTngdHomies(_ callback: IHomieContactCallBack) -> Void
    func addHomie(_ homie:ILocalContactProtocol, callback:(Result<IHomieContactProtocol,RPCError>) -> Void) -> Void
}
