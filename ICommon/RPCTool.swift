//
//  RPCTool.swift
//  ICommon
//
//  Created by Harvey on 2022/8/2.
//

import Foundation

public typealias RPCCallback = (Result<[String: Any], RPCError>) -> Void

public protocol PRCToolProtocol {
    func sendRequest(with operationTpe: String, params:[String: Any], callback: RPCCallback) -> Void
}

public enum RPCError: Error {
    case Parameter
    case Network
    case Json
    //code, message
    case Business(String, String)
}

public class RPCTool: PRCToolProtocol{
    public func sendRequest(with operationTpe: String, params:[String: Any], callback: RPCCallback) -> Void {
        //TODO:
    }
}
