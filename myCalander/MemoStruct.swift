//
//  MemoStruct.swift
//  myCalander
//
//  Created by junga oh on 2022/08/16.
//


import Foundation

// MARK: - Singleton class for static
class memoManager {
    static let shared: memoManager = memoManager()
    var memoStruct: Array<String> = Array<String>()
    
    private init() {
    }
}
