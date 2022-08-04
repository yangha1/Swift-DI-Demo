//
//  ICommonService.swift
//  ICommon
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import Swinject

public protocol DIRegistDelegate: AnyObject {
    func allBssemblys() -> Array<Assembly>
}

public class ICommonService {
    
    public weak var assemblyDelegate: DIRegistDelegate?
    
    public static let shared = {
        return ICommonService()
    }()
    
    public func setup() {
        let _ = self.assembler
    }
    
    public var resolver: Resolver {
        get {
            return assembler.resolver
        }
    }
    
    lazy var assembler: Assembler = {
        var assemblyArr = Array<Assembly>()
        if let dataSources = assemblyDelegate?.allBssemblys() {
            dataSources.forEach {assemblyArr.append($0)}
        }
        let container = Container()
        let assembler = Assembler(assemblyArr, container: container)
        return assembler
    }()
    
}






