//
//  IContactModule.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import IContactInterface
import UIKit

class IContactModule: IContactListProtocol {
    
    
    func contactList() -> UIViewController {
        return IContactListViewController(vm: IContactListViewModel())
    }
    
    func homieList() -> UIViewController {
        return IHomieListViewController(viewModel: IHomieListViewModel())
    }
}

