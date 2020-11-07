//
//  CoreDataAccess.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit
import CoreData

enum EntityName: String {
    case nature = "Nature"
}

class CoreDataAccess: NSObject {

    // MARK: - Variable Declaration
    public static var shared = CoreDataAccess()
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "ICloudSync")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        return container
    }()
    
    static var viewContext: NSManagedObjectContext {
        let context = self.shared.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = CoreDataAccess.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD operation
    func getAllPlaces() -> [Nature]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: EntityName.nature.rawValue)
        do {
            guard let arrPlaces = try CoreDataAccess.viewContext.fetch(fetchRequest) as? [Nature] else {
                return nil
            }
            print(arrPlaces.count)
            if arrPlaces.isEmpty {
                return nil
            } else {
                return arrPlaces
            }
        } catch let err {
            print("Error in  fetch :- \(err.localizedDescription)")
            return nil
        }
        
    }
    
    func insertPlaces(image: UIImage?, place: String?, address: String?, completion: @escaping () -> Void) {
        let context = CoreDataAccess.viewContext
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName.nature.rawValue, into: context) as? Nature else {
            return
        }
        entity.name = place
        entity.address = address
        entity.image = image?.pngData()
        do {
            try context.save()
            completion()
        } catch let err {
            print("save error :- \(err.localizedDescription)")
            completion()
        }
    }
    
    func deletePlace(_ place: Nature) {
        let context = CoreDataAccess.viewContext
        context.delete(place)
        do {
            try context.save()
        } catch let err {
            print("delete place data :- \(err.localizedDescription)")
        }
    }
    
}
