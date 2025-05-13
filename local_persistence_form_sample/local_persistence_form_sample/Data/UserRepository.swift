//
//  UserRepository.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

class UserRepository {

    let coreDataStack = CoreDataStack.shared

    func storeUser(user: UserModel) async throws -> Result<Bool, CoreDataError>{
        do {
            try coreDataStack.save(user: user)
            return .success(true)
        } catch let error as CoreDataError{
            return .failure(error)
        } catch {
            return .failure(CoreDataError.unknown)
        }
    }
}
