//
//  Vehicles.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct Vehicles:Codable{
    var count:Int
    var next: String?
    var previous:String?
    var results: [Vehicle]
}

struct Vehicle:Codable{
    var name:String
    var model:String
    var manufacturer:String
    var cost_in_credits:String
    var length:String
    var max_atmosphering_speed:String
    var crew:String
    var passengers:String
    var cargo_capacity:String
    var consumables:String
    var vehicle_class: String
    var pilots:[String]
    var films:[String]
    var created:String
    var edited:String
    var url:String
}
