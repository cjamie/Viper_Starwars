//
//  Person.swift
//  StarWars Viper
//
//  Created by Admin on 1/10/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

struct Person:Codable{
    var name:String
    var height:String
    var mass:String
    var hair_color:String
    var skin_color:String
    var eye_color:String
    var birth_year:String
    var gender:String
    var homeworld:String
    var films:[String]
    var species:[String]
    var vehicles:[String]
    var starships:[String]
    var created:String
    var edited:String
    var url:String
}
