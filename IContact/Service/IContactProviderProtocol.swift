//
//  IContactProviderProtocol.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation

protocol IContactProviderDelegate {
    func contactChanged(with contacts:Array<ILocalContactProtocol>) -> Void
}

protocol IContactProviderProtocol {
    
    var delegate: IContactProviderDelegate? {get set}
    func refreshContacts() -> Void
}
