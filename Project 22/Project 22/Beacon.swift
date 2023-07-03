//
//  Beacon.swift
//  Project 22
//
//  Created by Артем Чжен on 12/05/23.
//
import CoreLocation
//import UIKit

class Beacon {
    var uuid: UUID?
       var major: UInt16?
       var minor: UInt16?
       var identifier: String?
    
    init(uuid: UUID? = nil, major: UInt16? = nil, minor: UInt16? = nil, identifier: String? = nil) {
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.identifier = identifier
    }
}
