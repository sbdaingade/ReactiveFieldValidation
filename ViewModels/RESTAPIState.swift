//
//  RESTAPIState.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 28/03/21.
//

import Foundation
public enum RESTAPIState{
    case processing
    case finish
    case failWithError(Error)
}


