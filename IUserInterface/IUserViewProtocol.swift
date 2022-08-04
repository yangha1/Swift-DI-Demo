//
//  IUserViewProtocol.swift
//  IUserInterface
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import UIKit

public protocol IUserViewProtocol {
    
    func profileView() -> UIViewController
    func navigateToUserProfileView(with phoneNumber: String, targetVc: UIViewController)
    
}
