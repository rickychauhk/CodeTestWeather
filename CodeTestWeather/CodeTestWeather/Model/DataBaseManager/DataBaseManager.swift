//
//  DataBaseManager.swift
//  CodeTestWeather
//
//  Created by Ricky on 18/7/2021.
//

import Foundation
import RealmSwift

class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private var realm : Realm!
    
    //MARK: - Init
    private init() {
        realm = try! Realm()
    }
    
    func writeOperation(objectOfType:Object){
        try! realm.write {
            realm.add(objectOfType, update: .all)
        }
    }
    
    func getAllOperation(ofType: Object.Type) -> Results<Object>? {
        return realm!.objects(ofType.self)
    }
}
