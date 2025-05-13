//
//  UserStoreProtocol.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

import Foundation

protocol UserStoreProtocol {
    func save(user: UserModel) throws
    func delete(by hash: String) throws
    func fetchUsers() -> [UserEntity]
    func fetchUser(by hash: String) -> UserEntity?
}
