//
//  IHomieListViewController.swift
//  IContact
//
//  Created by Harvey on 2022/8/2.
//

import Foundation
import UIKit
import ICommon

protocol IHomieListViewDelegate {
    func navigateToUserView(with phoneNuber: String, targetVc: UIViewController) -> Void
}

class IHomieCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IHomieListViewController: UITableViewController {
    
    var vm: IHomieListViewModel
    var observations: [NSKeyValueObservation] = []
    var delegate: IHomieListViewDelegate? = IContactModuleDelegate()
    
    init(viewModel:IHomieListViewModel) {
        vm = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(IHomieCell.self, forCellReuseIdentifier: "cell")
        
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func bind() {
        observations = [
            vm.bind(\.title, to: navigationItem, at: \.title),
        ]
        vm.dataSourcesOnChange = {
            [unowned self] _ in
            self.tableView.reloadData()
        }
    }
    
    func refresh(){
        vm.refreshData()
    }
    
}

extension IHomieListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let homie = vm.dataSources[indexPath.section].homies[indexPath.row]
        delegate?.navigateToUserView(with: homie.phoneNumber, targetVc: self)
    }
    
}

extension IHomieListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return vm.dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = vm.dataSources[section]
        return group.homies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        let homie = vm.dataSources[indexPath.section].homies[indexPath.row]

        switch homie.type {
        case .tngdHomie:
            cell.textLabel?.text = "\(homie.tngdName!) (\(homie.name))"
        case .localHomie:
            cell.textLabel?.text = homie.name
        }
        cell.detailTextLabel?.text = homie.phoneNumber
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = vm.dataSources[section]
        return group.groupName
    }
}
