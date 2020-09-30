//
//  MenuViewController.swift
//  Bars
//
//  Created by Ахмед Фокичев on 30.09.2020.
//

import UIKit
import SnapKit

protocol MenuViewControllerDelegate {
    func selectTrasport(id: String)
}

class MenuViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var transports = [Transport]()
    var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.trailing.equalTo(self.view)
            $0.leading.equalTo(self.view)
            $0.bottom.equalTo(self.view)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let transport = transports[indexPath.row]
        cell.textLabel?.text = transport.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transport = transports[indexPath.row]
        delegate?.selectTrasport(id: transport.id)
        self.dismiss(animated: true, completion: nil)
    }
    
}
