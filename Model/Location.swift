//
//  Location.swift
//  milestone 1
//
//  Created by Min young Go on 4/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import Foundation


class Location{
    var name: String = ""
    var address: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    
    init(name: String, address: String, lat: Double, long: Double) {
        self.name = name
        self.address = address
        self.lat = lat
        self.long = long
    }
    
    
    
}



