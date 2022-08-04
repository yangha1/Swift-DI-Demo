//
//  IContactListViewController.swift
//  IContact
//
//  Created by Harvey on 2022/8/1.
//

import Foundation
import UIKit

class IContactCell: UITableViewCell {
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.add, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        return button
    }()
    
    var addClickCallBack: (()->Void)?
    
    @objc func didClickButton() {
        addClickCallBack?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(addButton)
        
        let rightContrains = NSLayoutConstraint(item: addButton, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -20)
        let centerContrains = NSLayoutConstraint(item: addButton, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([rightContrains,centerContrains])
    }
}


class IContactListViewController: UITableViewController {
    
    var vm: IContactListViewModel
    var observations: [NSKeyValueObservation] = []
    
    init(vm: IContactListViewModel) {
        self.vm = vm
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(IContactCell.self, forCellReuseIdentifier: "cell")
        bind()
        refresh()
    }
    
    func bind(){
        observations = [
            vm.bind(\.title, to: navigationItem, at: \.title),
        ]
        vm.dataSourcesOnChange = {
            [unowned self] _ in
            self.tableView.reloadData()
        }
    }
    
    func refresh() {
        vm.refreshData()
    }
}

extension IContactListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IContactCell
        let contact = vm.dataSources[indexPath.row]
        cell.addClickCallBack = {[unowned self] in
            self.vm.addHomie(homie: contact) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phoneNumber
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
