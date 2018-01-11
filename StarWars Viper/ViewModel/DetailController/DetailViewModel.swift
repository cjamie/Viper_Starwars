//
//  DetailViewModel.swift
//  StarWars Viper
//
//  Created by Admin on 1/8/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

class DetailViewModel:DetailViewModelDelegate{
    var detailViewController: DetailViewControllerDelegate?
    //public property that may only be set via functions
    public private(set) var myStruct: RetSingleType?
    
    init(_ delegate:DetailViewControllerDelegate){
        self.detailViewController = delegate
    }
 
    func setObject(_ myObj: RetSingleType){
        print("setting object in detailViewModel")
        print(myObj)
        self.myStruct = myObj
    }
}

