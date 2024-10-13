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
        
        let entity = NSEntityDescription.entity(forEntityName: "LocalWeatherEntity", in: context)
        let newStore = NSManagedObject(entity: entity!, insertInto: context)
        newStore.setValue(object.id, forKey: "id")
        newStore.setValue(object.latitude, forKey: "latitude")
        newStore.setValue(object.longitude, forKey: "longitude")
        
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
            let newProduct = WeatherEntities.LocalWeather(id: id, latitude: latitude, longitude: longitude)
            list.append(newProduct)
        }
        return list
    }
    
    func deleteContext(id: Int) async throws {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalWeatherEntity")
        request.predicate = NSPredicate(format: "id == %i", id)
        
        if let results = try context.fetch(request) as? [NSManagedObject]{
            for object in results {
                context.delete(object)
            }
        }
        
        if context.hasChanges {
            try context.save()
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
