//
//  EmployeesViewController.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 25/02/21.
//

import UIKit
import ReactiveKit
import Bond

class EmployeesViewController: UITableViewController {
    
    struct Input {
        let employees =  MutableObservableArray<EmployeeState>()
    }
    
    let input = Input()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.registerReusableHeaderFooterView(HeaderView.self)
        self.tableView.registerReusableCell(EmployeeCell.self)
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        input.employees.bind(to: tableView) { (employees, indexPath, tableView) -> UITableViewCell in
            let emp = employees.item(at: indexPath)
            let cell = tableView.dequeueReusableCell(indexPath: indexPath, cellType: EmployeeCell.self)
            cell.configureCell(withEmployee: emp)
            
            return cell
        }.dispose(in: bag)
        
        
        tableView.reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:)), dispatch: { (subject: PassthroughSubject<Void, Never>, tableView: UITableView, view: UITableViewHeaderFooterView, section: Int) in
            _ = tableView.dequeueReusableHeaderFooterView(HeaderView.self)
        }).bind(to: tableView) { _ in }.dispose(in: bag)
        
    }
    
    deinit {
    }
}
extension EmployeesViewController {
    static func makeViewController(mainState: MainState) -> EmployeesViewController {
        let employeesViewController = EmployeesViewController()
        employeesViewController.title = "Employees".localized()
        
        mainState.output.employees.bind(to: employeesViewController.input.employees).dispose(in: employeesViewController.bag)
        return employeesViewController
    }
}

