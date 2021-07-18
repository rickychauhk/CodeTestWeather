//
//  RealmManager.swift
//  CodeTestWeather
//
//  Created by Ricky on 18/7/2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    //MARK: - Shared Singleton
    static let shared = RealmManager()
    
    private var realm : Realm!
    
    //MARK: - Init
    
    private init() {
        realm = try! Realm()
    }
    
    //MARK: - CRUD
    func writeOperation(objectOfType:Object){
        try! realm.write {
            realm.add(objectOfType, update: .all)
        }
    }
    
    func getAllOperation(ofType: Object.Type) -> Results<Object>? {
        return realm!.objects(ofType.self)
    }
}
