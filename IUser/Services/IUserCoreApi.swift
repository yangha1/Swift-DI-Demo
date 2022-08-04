//
//  IUserApi.swift
//  IUser
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import ICommon
import IUserInterface

protocol IUserResponseProtocol {
    var isOnus: Bool {get}
    var tnguser: ITngUserInfoProtocol? {get}
}

struct IUserResponse: IUserResponseProtocol {
    var isOnus: Bool
    var tnguser: ITngUserInfoProtocol?
    
    init?(with dict:[String: Any]) {
        guard let onus = dict["onus"] as? Bool else {
            return nil
        }
        
        if onus {
            guard let userDict = dict["user"] as? Dictionary<String,Any>,
                  let name = userDict["name"] as? String,
                  let phone = userDict["phoneNumber"] as? String else {
                return nil
            }
            tnguser = ITngUserInfo(nickName: name, phoneNumber: phone)
        }
                
        isOnus = onus

    }
}


protocol IUserCoreApi {
    func getUserInfo(
        with phoneNumber: String,
        callback:(Result<IUserResponseProtocol,RPCError>) -> Void)
    -> Void
}

class IUserCoreApiImpl: IUserCoreApi{

    var rpctool: PRCToolProtocol? = MockRPCTool()
    
    func getUserInfo(with phoneNumber: String, callback: (Result<IUserResponseProtocol,RPCError>) -> Void) {
        
        rpctool?.sendRequest(
            with: "com.tngd.uerinfo.get",
            params: ["phoneNumber":phoneNumber],
            callback: { result in
                
                let response:Result<IUserResponseProtocol,RPCError> = result.flatMap { dict in
                    
                    guard let user = IUserResponse(with: dict) else {
                        return Result.failure(.Json)
                    }
                    
                    return Result.success(user)
                }
                callback(response)
                
            })
    }
    
}


//Mark:Mock for Test
class MockRPCTool: PRCToolProtocol{
    
    let phones = [
        "1234567890",
        "1234567891",
        "1234567892",
        "1234567893",
        "1234567894",
        "1234567895",
        "1234567896",
        "1234567897",
        "1234567898",
        "1234567899",
    ]
    
    let nameMap = [
        "1234567890":"Tony Wang",
        "1234567891":"Andy Liu",
        "1234567892":"Nico Yu",
        "1234567893":"Lucy Liu",
        "1234567894":"Cindy Wang",
        "1234567895":"Jay Chou",
        "1234567896":"Luis VV",
        "1234567897":"Hermes",
        "1234567898":"Luna",
        "1234567899":"Coco Li",
    ]
    
    func sendRequest(with operationTpe: String, params: [String : Any], callback: (Result<[String : Any], RPCError>) -> Void) {
        guard let phoneNumber = params["phoneNumber"] as? String else {
            callback(Result.failure(.Parameter))
            return
        }
        
        var response = Dictionary<String,Any>()
        let onus = phones.contains(phoneNumber)
        if onus {
            let name = nameMap[phoneNumber]!
            var user = Dictionary<String,Any>()
            user["name"] = name
            user["phoneNumber"] = phoneNumber
            response["user"] = user
        }
        response["onus"] = onus
        callback(Result.success(response))
        
    }
}
