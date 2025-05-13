//
//  CoreDataError.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

enum CoreDataError: String, Error {
    case alreadyExists
    case notFound
    case cannotStore
    case unknown
}
