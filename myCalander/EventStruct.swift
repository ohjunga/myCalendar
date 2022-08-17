//
//  EventStruct.swift
//  myCalander
//
//  Created by junga oh on 2022/08/16.
//

import Foundation

// MARK: - Singleton class for static
class dataManager {
    static let shared: dataManager = dataManager()
    var eventStruct: Array<saveEvent> = Array<saveEvent>()
    var password: Array<String> = Array<String>()
    var lockBool: Bool = false
    var localLockStatus: Bool = false
    private init() {
    }
}

struct saveEvent {
    var event: String
    var title: String
    var color: String
}
