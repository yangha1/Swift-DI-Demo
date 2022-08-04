//
//  IContactListViewModel.swift
//  IContact
//
//  Created by Harvey on 2022/8/1.
//

import Foundation
import IContactInterface
import ICommon
import CoreText

class IContactListViewModel: NSObject{
    
    //dependency
    lazy var contactProvider: IContactProviderProtocol = IContactServices.shared
    lazy var homieProvider:IHomieContactProviderProtocol = IContactServices.shared
    
    @objc dynamic lazy var title: String? = "Contact"
    lazy var dataSources = Array<ILocalContactProtocol>()
    var dataSourcesOnChange: ((Array<ILocalContactProtocol>) -> Void)?
    
    override init(){
        super.init()
        bind()
    }
    
    func bind() {
        contactProvider.delegate = self
    }
    
    func refreshData() {
        contactProvider.refreshContacts()
    }
    
    func addHomie(homie: ILocalContactProtocol, callback:()->Void){
        homieProvider.addHomie(homie) { result in
            callback()
        }
    }
    
}

extension IContactListViewModel: IContactProviderDelegate {
    func contactChanged(with contacts: Array<ILocalContactProtocol>) {
        dataSources = contacts
        dataSourcesOnChange?(dataSources)
    }
}
