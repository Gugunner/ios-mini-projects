//
//  CoreDataStack.swift
//  local_persistence_form_sample
//
//  Created by Raul_Alonzo on 13/05/25.
//

import Foundation
import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "local_persistence_form_sample")

        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()

    private init() { }
}

extension CoreDataStack {

    func save() {
        guard persistentContainer.viewContext.hasChanges else { return }

        do {
            try persistentContainer.viewContext.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to save the context:", error.localizedDescription)
        }
    }

    func delete(item: NSManagedObject) {
        let objectID = item.objectID

        persistentContainer.performBackgroundTask { context in
            do {
                if let backgroundObject = try? context.existingObject(
                    with: objectID
                ) {
                    context.delete(backgroundObject)
                    try context.save()
                }
            } catch {
                print("Cannot delete background object:", error)
            }
        }
    }
}

extension CoreDataStack: UserStoreProtocol {
    func save(user: UserModel) throws {
        let hash = "\(user.userName)|\(user.email)"
        guard fetchUser(by: hash) == nil else {
            throw CoreDataError.alreadyExists
        }
        print("Saving user")
        let context = persistentContainer.viewContext
        let entity = UserEntity(context: context)
        entity.id = user.id
        entity.userName = user.userName
        entity.email = user.email.lowercased()
        save()
    }

    func delete(by hash: String) throws {
        guard let entity = fetchUser(by: hash) else {
            throw CoreDataError.notFound
        }
        delete(item: entity)
    }

    func fetchUsers() -> [UserEntity] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch users:", error)
            return []
        }
    }

    func fetchUser(by hash: String) -> UserEntity? {
        print("Fetching Use with hash \(hash)")
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        let parts = hash.split(separator: "|")
        let userName = String(parts.first ?? "")
        let email = String(parts.last ?? "")
        request.predicate = NSPredicate(
            format: "userName == %@ OR email == %@",
            argumentArray: [userName, email]
        )
        request.fetchLimit = 1
        do {
            return try context.fetch(request).first
        } catch {
            print("No user in store with hash \(hash)")
            return nil
        }
    }
}
