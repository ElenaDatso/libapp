//
//  Person.swift
//  PocketLibrary
//
//  Created by Elena Datso on 2026-03-25.
//

import Foundation

class Person {
    var name: String
    init(name: String) { self.name = name }
    deinit { print("\(name) удалён") }
}

var p: Person? = Person(name: "Alex")
var weakRef = p

