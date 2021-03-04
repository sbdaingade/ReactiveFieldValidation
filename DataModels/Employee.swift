//
//  Employee.swift
//  ReactiveFieldsValidation
//
//  Created by Sachin Daingade on 25/02/21.
//

import Foundation

struct Employee: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
