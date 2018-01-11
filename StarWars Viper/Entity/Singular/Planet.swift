//
//  Planet.swift
//  StarWars Viper
//
//  Created by Admin on 1/10/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct Planet:Codable{
    var name:String
    var rotation_period:String
    var orbital_period:String
    var diameter:String
    var climate:String
    var gravity:String
    var terrain:String
    var surface_water:String
    var population:String
    var residents:[String]
    var films:[String]
    var created:String
    var edited:String
    var url:String
}
