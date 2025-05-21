//
//  UserModel.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

import Foundation

struct UserModel {
    let id: UUID
    let userName: String
    let email: String
    let timestamp: Date

    init(id: UUID, userName: String, email: String, timestamp: Date? = nil) {
        self.id = id
        self.userName = userName
        self.email = email
        self.timestamp = timestamp ?? Date()
    }
}
