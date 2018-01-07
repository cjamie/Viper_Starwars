//
//  ObjectInteractor.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation
import Alamofire
/*
 -contains all of the business logic related to my entities
 -should be completely UI independent (NO UIKIT)
 -handles the responses and convert them into an entity
 -once interactor finishes a task, it notifies the presenter about the results obtained.
 ---- may notify via KVO or 
 */

protocol InteractorInput: class {
    func fetchObjects()
//    func fetchExample()
}

class Interactor: InteractorInput{
    //Weak reference to Presenter Output interface
    weak var output: InteractorInput!
    let url = " " //url of desired API
    
    func fetchObjects(){
        
    }

}
