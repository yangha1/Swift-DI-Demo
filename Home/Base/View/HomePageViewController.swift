//
//  HomePageViewController.swift
//  Home
//
//  Created by Harvey on 2022/8/1.
//

import Foundation
import UIKit

protocol HomeUiDelegate {
    func homieListView() -> UIViewController
    func contactListView() -> UIViewController
    func profileView() -> UIViewController
}

class HomePageViewController: UIViewController {
    
    var uiDelegate: HomeUiDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    func setupViews() {
        title = "Homie"
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(didClickRightBarItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(didClickLeftBarItem))
        
        if let vc = uiDelegate?.homieListView() {
            self.addChild(vc)
            view.addSubview(vc.view)
            vc.view.frame = view.bounds
        }
    }
    
    @objc func didClickRightBarItem() {
        if let vc = uiDelegate?.contactListView(){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didClickLeftBarItem() {
        if let vc = uiDelegate?.profileView(){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
