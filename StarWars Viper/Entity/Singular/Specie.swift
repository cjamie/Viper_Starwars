//
//  Specie.swift
//  StarWars Viper
//
//  Created by Admin on 1/10/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct Specie:Codable{
    var name:String
    var classification:String
    var designation:String
    var average_height:String
    var skin_colors:String
    var hair_colors:String
    var eye_colors:String
    var average_lifespan:String
    var homeworld:String?
    var language:String
    var people: [String]
    var films:[String]
    var created:String
    var edited:String
    var url:String
}
