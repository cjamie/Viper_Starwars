//
//  ViewControllerDelegate.swift
//  StarWars Viper
//
//  Created by Admin on 1/8/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

protocol ViewControllerDelegate:class {
        var dataCount:Int? {get}
        var selectedObject:RetSingleType? {get}
}
