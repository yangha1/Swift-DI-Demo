//
//  IHomieListViewModel.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation

protocol IHomieGroupProtocol {
    var groupName: String {get}
    var homies:Array<IHomieContactProtocol> {get}
}

struct IHomieGroup: IHomieGroupProtocol {
    var groupName: String
    var homies:Array<IHomieContactProtocol>
}

class IHomieListViewModel : NSObject{
    
    //dependency
    lazy var homieProvider: IHomieContactProviderProtocol = IContactServices.shared
    
    @objc dynamic lazy var title: String? = "Homie"
//    @objc dynamic lazy var dataSources = Array<IHomieGroupProtocol>()
    lazy var dataSources = Array<IHomieGroupProtocol>()
    var dataSourcesOnChange: ((Array<IHomieGroupProtocol>) -> Void)?
    
    func refreshData() {
        
        //need async await
        var array = Array<IHomieGroupProtocol>()
        homieProvider.getTngdHomies { result in
            if case .success(let homies) = result {
                let group = IHomieGroup(groupName: "TNGD Homie", homies: homies)
                array.append(group)
            }
        }
        
        homieProvider.getLocalHomies { result in
            if case .success(let homies) = result {
                let group = IHomieGroup(groupName: "Non-TNGD Homie", homies: homies)
                array.append(group)
            }
        }
        
        dataSources = array
        dataSourcesOnChange?(dataSources)
    }
    
}
