//
//  CoreData+Extension.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/19/21.
//

import Foundation
import CoreData

extension NSManagedObject {
    static func markDirty<C, T>(_ obj: C, _ keyPath: ReferenceWritableKeyPath<C, T>) {
        obj[keyPath: keyPath] = obj[keyPath: keyPath]
    }

	func addObject(value: NSManagedObject, forKey: String) {
		var items = self.mutableSetValue(forKey: forKey);
		items.add(value)
	}

//    open func setIfDifferent(_ newValue: Any?,forKey key: String) {
//        if let currValue = value(forKey: key) {
//            if let newValueUnwrapped = newValue {
//                if newValueUnwrapped != currValue {
//                    setValue(newValue, forKey: key) // set the field already
//                }
//            }
//        } else { // existing value is nil
//            if let newValueUnwrapped = newValue {
//                setValue(newValue, forKey: key) // set the field already
//            }
//        }
//    }
}
