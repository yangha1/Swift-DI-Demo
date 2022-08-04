//
//  IUserModule.swift
//  IUser
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import IUserInterface
import UIKit
import ICommon

class IUserModule: IUserViewProtocol {
    func profileView() -> UIViewController {
        return IUserProfileViewController()
    }
    
    func navigateToUserProfileView(with phoneNumber: String, targetVc: UIViewController) {
        //todo
        let message = "PhoneNumber: \(phoneNumber)"
        let alert = UIAlertController(title: "User info view is under development", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel))
        targetVc.present(alert, animated: true)
    }
}

extension IUserModule: IUserServciesProtocol {
    func checkTngdUser(with phoneNumber: String, callback: (Bool?, ITngUserInfoProtocol?, RPCError?) -> Void) {
        let api = IUserCoreApiImpl()
        
        api.getUserInfo(with: phoneNumber) { result in
            switch result {
            case .success(let response):
                if response.isOnus {
                    callback(true,response.tnguser,nil)
                }else{
                    callback(false,response.tnguser,nil)
                }
            case .failure(let error):
                callback(nil,nil,error)
            }
        }
    }
}
