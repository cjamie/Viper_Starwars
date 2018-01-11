//
//  ViewModelDelegate.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation


protocol ViewModelDelegate:class{
    func getAllObjects(curr:String, completion: @escaping()->())
    func getObjectNames(for:Int)->String
    func getObjectArrayCount()->Int
    func getObject(by index:Int)->RetSingleType
    
    //TODO: function for changing for changing between categories in tabbarcontroller.
    
    func changeDataArr(with url:String)
    func generateLoadUrl(with title:String)->String
    
}
