//
//  MainState.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 28/03/21.
//

import Foundation
import ReactiveKit
import Bond

class MainState {
    typealias fetchEmployeeRecords = Fetcher<Employee>
    struct Input{
        public enum InputAction {
            case getAllEmployees
        }
        public let action = PassthroughSubject<InputAction,Never>()
    }
    struct Output{
        let employees = MutableObservableArray<EmployeeState>()
        public let requestState = PassthroughSubject<RESTAPIState,Never>()
        
    }
    
    let input = Input()
    let output = Output()
    let bag = DisposeBag()
    
    init() {
        
        input.action.observeNext{[unowned self] action in
            
            switch action{
            case .getAllEmployees:
                self.output.requestState.send(.processing)
                self.output.employees.removeAll()
                fetchEmployeeRecords.init().fetchList(withURL: "https://jsonplaceholder.typicode.com/posts") { emps, error in
                    if error != nil{
                        self.output.requestState.send(.failWithError(error as! Error))
                        return
                    }
                    
                    for emp in emps{
                        let employeeState = EmployeeState(employee: emp)
                        self.output.employees.append(employeeState)
                    }
                    self.output.requestState.send(.finish)
                }
                
            }
            
        }.dispose(in: bag)
        
    }
    
    deinit {
        bag.dispose()
    }
    
}
