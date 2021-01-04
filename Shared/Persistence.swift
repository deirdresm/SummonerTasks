//
//  Persistence.swift
//  Shared
//
//  Created by Deirdre Saoirse Moen on 11/30/20.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer
    
//    var backgroundContext: NSManagedObjectContext {
//        get {}
//        
//        set {}
//    }
//
    /**
     Creates and configures a private queue context.
    */
    

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for i in 0..<10 {
//            let newRune = RuneInstance(context: viewContext)
//            newRune.name = "Rune \(i)"
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()


    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SummonerTasks")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        if #available(iOS 13, macOS 10.15, *) {
            // Enable remote notifications
            guard let description = container.persistentStoreDescriptions.first else {
                fatalError("Failed to retrieve a persistent store description.")
            }
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        // This sample refreshes UI by refetching data, so doesn't need to merge the changes.
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        if #available(iOS 13, macOS 10.15, *) {
            // Observe Core Data remote change notifications.
            NotificationCenter.default.addObserver(
                self, selector: #selector(type(of: self).storeRemoteChange(_:)),
                name: .NSPersistentStoreRemoteChange, object: nil)
        }
    }
    
    /**
     Creates and configures a private queue context.
    */
    public func newTaskContext() -> NSManagedObjectContext {
        // Create a private queue context.
        let taskContext = container.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // Set unused undoManager to nil for macOS (it is nil by default on iOS)
        // to reduce resource requirements.
        taskContext.undoManager = nil
        return taskContext
    }

    
    // MARK: - NSPersistentStoreRemoteChange handler

    /**
     Handles remote store change notifications (.NSPersistentStoreRemoteChange).
     storeRemoteChange runs on the queue where the changes were made.
     */
    @objc
    func storeRemoteChange(_ notification: Notification) {
        // print("\(#function): Got a persistent store remote change notification!")
    }
    
    // MARK: - Rune background tasks

    //  After we've imported runes from the JSON file, any runes that *weren't*
    //  included should be deleted (as the summoner no longer has those runes).
    
    //  Note: we can't rely on the changed runes as most will be unchanged, and
    //  updating a timestamp seems clumsy (and prone to edge cases). Current
    //  max # of runes is 1800, so keeping an array is not unduly memory
    //  burdensome.
    
    private func deleteUnchangedRunes(_ seenRunes: Set<RuneInstance>, completionHandler: @escaping (Error?) -> Void) {
        let taskContext = newTaskContext()

        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RuneInstance")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            
            // Execute the batch insert
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completionHandler(nil)

            } else {
                completionHandler(RuneError.unknownError)
            }
        }
    }

}
