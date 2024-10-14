//
//  CoreDataManager.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import CoreData
import WeatherDataSource
import Utils
import WeatherEntities

class CoreDataManager: WeatherDBLocalDataSource {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataBase",
                                              bundle: Bundle(for: type(of: self)))
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext(object: WeatherEntities.LocalWeather) async throws {
        let context = persistentContainer.viewContext
        dump(object)
        let entity = NSEntityDescription.entity(forEntityName: "LocalWeatherEntity", in: context)
        let newStore = NSManagedObject(entity: entity!, insertInto: context)
        newStore.setValue(object.id, forKey: "id")
        newStore.setValue(object.latitude, forKey: "latitude")
        newStore.setValue(object.longitude, forKey: "longitude")
        newStore.setValue(object.longitude, forKey: "notification")
        newStore.setValue(object.registered, forKey: "registered")
        newStore.setValue(object.city, forKey: "city")
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func getContext() async throws -> [WeatherEntities.LocalWeather] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalWeatherEntity")
        request.returnsObjectsAsFaults = false
        
        let result = try persistentContainer.viewContext.fetch(request)
        var list: [WeatherEntities.LocalWeather] = []
        for data in result as! [NSManagedObject] {
            let id = data.value(forKey: "id") as? Int ?? 0
            let latitude = data.value(forKey: "latitude") as? Double ?? 0
            let longitude = data.value(forKey: "longitude") as? Double ?? 0
            let notification = data.value(forKey: "notification") as? Bool ?? false
            let registered = data.value(forKey: "registered") as? Date ?? Date()
            let city = data.value(forKey: "city") as? String ?? ""
            let newProduct = WeatherEntities.LocalWeather(id: id, latitude: latitude,
                                                          longitude: longitude, notification: notification,
                                                          registered: registered, city: city)
            list.append(newProduct)
        }
        return list
    }
    
    func deleteContext(id: Int) async throws {
        let context = persistentContainer.viewContext
        let results = try await searchObjects(id: id)
        guard !results.isEmpty else {
            return
        }
        for object in results {
            context.delete(object)
        }
        
        if context.hasChanges {
            try context.save()
        }
    }
    
    func update(id: Int, notification: Bool) async throws {
        let context = persistentContainer.viewContext
        let results = try await searchObjects(id: id)
        guard let first = results.first else {
            return
        }
        first.setValue(notification, forKey: "notification")
        if context.hasChanges {
            try context.save()
        }
    }
    
    private func searchObjects(id: Int) async throws -> [NSManagedObject] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalWeatherEntity")
        request.predicate = NSPredicate(format: "id == %i", id)
        if let results = try context.fetch(request) as? [NSManagedObject] {
            return results
        } else {
            return []
        }
    }
}

extension NSPersistentContainer {
    public convenience init(name: String, bundle: Bundle) {
        guard let modelURL = bundle.url(forResource: name, withExtension: "momd"),
              let mom = NSManagedObjectModel(contentsOf: modelURL)
        else {
            fatalError("Unable to located Core Data model")
        }
        self.init(name: name, managedObjectModel: mom)
    }
}
