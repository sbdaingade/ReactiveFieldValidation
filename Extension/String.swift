//
//  String.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 18/02/21.
//

import Foundation

public extension String{
    func isValidForType(type: Validation) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", type.description).evaluate(with: self)
    }

    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

public enum Validation: CustomStringConvertible {
    case email
    case password
    case userName
    case textInput(UInt8)
    
    public var description: String {
        switch self {
        case .email:
            return "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        case .password:
            return "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z` ~ ! @ # ${'$'} % ^ * ( ) _ _ + + .  - - - = { } | \\[ \\] & \\ :  ; ' < > ? , . ]{8,18}$"
        case .userName:
            return "^[A-Za-z][A-Za-z0-9 _-]{0,17}"
        case .textInput(let maxSize):
            return "^.{1,\(maxSize)}"
        }
    }
    
}

/*
 
 tableView.tableFooterView = UIView()
 tableView.registerReusableHeaderFooterView(HeaderView.self)


 tableView.reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:viewForHeaderInSection:)), dispatch: { (subject: PassthroughSubject<UIView?, Never>, tableView: UITableView, section: Int) -> UIView? in
     guard let headerView = tableView.dequeueReusableHeaderFooterView(HeaderView.self) else {
         return nil
     }
     return headerView
 }).bind(to: tableView) { _,_  in }.dispose(in: bag)
 */
