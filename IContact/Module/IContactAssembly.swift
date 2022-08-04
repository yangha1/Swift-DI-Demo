//
//  IContactAssembly.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import Swinject
import IContactInterface

public class IContactAssembly: Assembly{
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(IContactListProtocol.self) { _ in
            IContactModule()
        }
        
    }
}
