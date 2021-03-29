//
//  EmployeeCell.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 04/03/21.
//

import UIKit
import RealityKit
import Bond
class EmployeeCell: UITableViewCell,TableViewReuseableProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(withEmployee employeeState: EmployeeState)
    {
        employeeState.output.name.bind(to: titleLabel).dispose(in: bag)
        employeeState.output.description.bind(to: subTitleLabel).dispose(in: bag)
    }
}
