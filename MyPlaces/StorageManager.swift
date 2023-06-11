//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Сергій Павлик on 30.05.2023.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place){
        
        try! realm.write{
            realm.add(place)
        }
//        print(Realm.Configuration.defaultConfiguration.fileURL)
//        показивает путь до realm файла в консоли
        
    }
    
    static func deleteObject(place: Place){
        try! realm.write{
            realm.delete(place)
        }
    }
}

