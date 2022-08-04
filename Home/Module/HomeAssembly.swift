//
//  HomeAssembly.swift
//  Home
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import Swinject
import HomeInterface

public class HomeAssembly: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(HomeViewProtocol.self) { _ in
            return HomeModule()
        }
        
    }
    
}
