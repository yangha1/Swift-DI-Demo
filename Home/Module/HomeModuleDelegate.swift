//
//  HomeModuleDelegate.swift
//  Home
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import UIKit
import ICommon
import IContactInterface
import IUserInterface

class HomeModuleDelegate {
    
    //business layer dependency
    lazy var contactListImpl = ICommonService.shared.resolver.resolve(IContactListProtocol.self)!
    lazy var profileViewImpl = ICommonService.shared.resolver.resolve(IUserViewProtocol.self)!
    
}

extension HomeModuleDelegate: HomeUiDelegate {
    func homieListView() -> UIViewController {
        let vc = contactListImpl.homieList()
        return vc
    }
    
    func contactListView() -> UIViewController {
        let vc = contactListImpl.contactList()
        return vc
    }
    
    func profileView() -> UIViewController {
        let vc = profileViewImpl.profileView()
        return vc
    }
}
