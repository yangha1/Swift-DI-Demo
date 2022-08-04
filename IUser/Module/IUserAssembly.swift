//
//  IUserAssembly.swift
//  IUser
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import Swinject
import IUserInterface

public class IUserAssembly: Assembly{
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(IUserViewProtocol.self) { _ in
            IUserModule()
        }
        
        container.register(IUserServciesProtocol.self) { _ in
            IUserModule()
        }
    }
}
