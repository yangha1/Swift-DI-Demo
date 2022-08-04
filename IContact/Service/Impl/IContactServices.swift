//
//  IContactServices.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import ICommon

protocol IContactServiceDelegate {
    func getHomieInfo(with local: ILocalContactProtocol, callback:(Result<IHomieContactProtocol,RPCError>) -> Void) -> Void
}


class IContactServices {
    
    static let shared = IContactServices()
    
    var refreshed: Bool = false
    
    //Dependency
    var serviceDelegate: IContactServiceDelegate = IContactModuleDelegate()
    var contactDataSource: IContactDatastoreProtocol = IContactDatastoreMock()
    
    //TODO: add thread safe lock
    lazy var localHomies: Array<IHomieContactProtocol> = Array<IHomieContactProtocol>()
    lazy var tngdHomies: Array<IHomieContactProtocol> = Array<IHomieContactProtocol>()
    
    var contacts: Array<ILocalContactProtocol> = Array<ILocalContactProtocol>()
    var delegate: IContactProviderDelegate? {
        didSet {
            delegate?.contactChanged(with: contacts)
        }
    }
    
}

extension IContactServices: IContactProviderProtocol {
    func refreshContacts() {
        
        if refreshed {
            return
        }
        
        contactDataSource.getAllContact { result in
            if case .success(let arr) = result {
                self.refreshed = true
                contacts = arr
                self.delegate?.contactChanged(with: contacts)
            }
        }
    }
}

extension IContactServices :IHomieContactProviderProtocol {
    func getLocalHomies(_ callback: (Result<Array<IHomieContactProtocol>, IHomieContactError>) -> Void) {
        callback(Result.success(localHomies))
    }
    
    func getTngdHomies(_ callback: (Result<Array<IHomieContactProtocol>, IHomieContactError>) -> Void) {
        callback(Result.success(tngdHomies))
    }

    func addHomie(_ homie:ILocalContactProtocol, callback:(Result<IHomieContactProtocol,RPCError>) -> Void) -> Void {
        
        serviceDelegate.getHomieInfo(with: homie) { result in
            
            if case .success(let homie) = result {
                
                contacts.removeAll { contact in
                    contact.phoneNumber == homie.phoneNumber
                }
                delegate?.contactChanged(with: contacts)
                
                switch homie.type {
                case .localHomie:
                    localHomies.append(homie)
                case .tngdHomie:
                    tngdHomies.append(homie)
                }
                
            }
            callback(result)
        }
    }
}
