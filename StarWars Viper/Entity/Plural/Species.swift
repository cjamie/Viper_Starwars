//
//  Species.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct Species:Codable{
    var count:Int
    var next: String?
    var previous:String?
    var results: [Specie]
}



