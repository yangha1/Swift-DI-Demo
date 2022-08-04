//
//  HomeModule.swift
//  Home
//
//  Created by Harvey on 2022/8/1.
//

import Foundation
import HomeInterface
import UIKit
import Swinject

class HomeModule: HomeViewProtocol {
    
    public func homeView() -> UIViewController {
        let vc = HomePageViewController()
        vc.uiDelegate = HomeModuleDelegate()
        return vc
    }
    
    public func home2View() -> UIViewController {
        let vc = HomePageViewController()
        vc.uiDelegate = HomeModuleDelegate()
        return vc
    }
}

