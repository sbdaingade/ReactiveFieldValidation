//
//  EmployeeState.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 28/03/21.
//

import Foundation
import Bond
import ReactiveKit

struct EmployeeState{
    
    struct Input {
       public enum InputAction{
            case getAllEmployees
        }
        public let action = PassthroughSubject<InputAction,Never>()
    }
    
    struct Output {
        let employees = MutableObservableArray<Employee>()
        let name =  Observable<String?>(nil)
        let empID = Observable<Int>(0)
        let description = Observable<String?>(nil)
    }
    
    let output = Output()
    let input = Input()
    private let bag = DisposeBag()
    
    init(employee :Employee) {
        self.output.name.value = employee.title
        self.output.empID.value = employee.id
        self.output.description.value = employee.body
    }
    
    
}



