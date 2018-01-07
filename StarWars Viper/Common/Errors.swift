//
//  Errors.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

enum NetworkError:Error{
    case noResponse
    case responseError(Int)
    case noData
    case couldNotParseData
    case invalidImage
}
