//
//  UserMapper.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//


extension UserEntity {
    var model: UserModel? {
        guard let id, let userName, let email, let timestamp else { return nil }
        return UserModel(
            id: id,
            userName: userName,
            email: email,
            timestamp: timestamp
        )
    }
}

