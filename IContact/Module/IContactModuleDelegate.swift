//
//  IContactModuleDelegate.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import UIKit
import ICommon
import IUserInterface

class IContactModuleDelegate {
    lazy var userServicesImpl = ICommonService.shared.resolver.resolve(IUserServciesProtocol.self)!
    lazy var userViewImpl = ICommonService.shared.resolver.resolve(IUserViewProtocol.self)!
}

extension IContactModuleDelegate: IContactServiceDelegate {
    func getHomieInfo(with local: ILocalContactProtocol, callback: (Result<IHomieContactProtocol, RPCError>) -> Void) {
        
        userServicesImpl.checkTngdUser(with: local.phoneNumber) { isTngUser, tnguser, error in
            
            if let error = error {
                callback(Result.failure(error))
                return
            }
            
            var homie: IHomieContact
            if isTngUser! {
                homie = IHomieContact(name: local.name, phoneNumber: tnguser!.phoneNumber, type: .tngdHomie, tngdName: tnguser!.tngdName)
            }else{
                homie = IHomieContact(name: local.name, phoneNumber: local.phoneNumber, type: .localHomie)
            }
            
            callback(Result.success(homie))
            
        }
        
    }
}

extension IContactModuleDelegate: IHomieListViewDelegate {
    func navigateToUserView(with phoneNuber: String, targetVc: UIViewController) {
        userViewImpl.navigateToUserProfileView(with: phoneNuber, targetVc: targetVc)
    }
}
