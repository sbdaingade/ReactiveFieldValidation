//
//  Extension.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 16/02/21.
//

import Foundation
import UIKit

public protocol TableViewReuseableProtocol: class {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension TableViewReuseableProtocol {
    static public var reuseIdentifier: String { return String(describing: self) }
    static public var nibName: String {return String(describing: self)}
}

// MARK: - UITableView extention to register and dequeue reusable cell and header view
internal extension UITableView {
    /// Register cell with class wich adopts TableViewReuseableProtocol
    ///
    /// - Parameter cellType: Cell type of class wich adopts TableViewReuseableProtocol
    final func registerReusableCell<T: UITableViewCell>(_ cellType: T.Type) where T: TableViewReuseableProtocol {
        let bundle = Bundle.main
        if let _ = bundle.path(forResource: String(cellType.nibName), ofType: "nib") {
            self.register(UINib(nibName: String(cellType.nibName), bundle: bundle), forCellReuseIdentifier: cellType.reuseIdentifier)
        } else {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    /// Dequeue reusable cell for specific type
    ///
    /// - Parameters:
    ///   - indexPath: IndexPath for cell wich should be dequeue
    ///   - cellType: expected Cell type
    /// - Returns: Cell with specifed type
    final func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, cellType: T.Type) -> T where T: TableViewReuseableProtocol {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    /// Register header with class wich adopts TableViewReuseableProtocol
    ///
    /// - Parameter headerType: Header type of class wich adopts TableViewReuseableProtocol
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerType: T.Type) where T: TableViewReuseableProtocol {
        let bundle = Bundle.main
        if let _ = bundle.path(forResource: String(headerType.nibName), ofType: "nib"){
            self.register(UINib(nibName: String(headerType.nibName), bundle: bundle), forHeaderFooterViewReuseIdentifier: headerType.reuseIdentifier)
        } else {
            self.register(headerType.self, forHeaderFooterViewReuseIdentifier: headerType.reuseIdentifier)
        }
    }
    
    /// Dequeue reusable header footer view for specific type
    ///
    /// - Parameter headerType: expected Header type
    /// - Returns: Header with specifed type
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerType: T.Type) -> T? where T: TableViewReuseableProtocol {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: headerType.reuseIdentifier) as? T else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(T.reuseIdentifier) matching type \(T.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the header/footer beforehand"
            )
        }
        return headerFooterView
    }
    
    /// Indicates whether or not cell at index path is last visible cell
    ///
    /// - Parameter indexPath: IndexPath of cell
    /// - Returns: Return true if cell at index path is last visible cell otherwise false
    final func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}

extension UITableView {
    func setEmtyDataMessage(withMessage message: String) {
        let tipLabel = UILabel()
        tipLabel.text = message
        tipLabel.numberOfLines = 0
        tipLabel.textColor = UIColor.customColor(CustomColors.labelTextColor)
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.textAlignment = .center
        self.backgroundView = tipLabel
        self.backgroundView?.alpha = 0
        tipLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tipLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -44).isActive = true
    }
}



extension UIColor{
    class func customColor(_ color: CustomColors) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}
public enum CustomColors: String {
    case white
    case errorRed
    case labelTextColor
}
