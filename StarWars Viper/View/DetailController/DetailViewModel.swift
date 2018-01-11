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
    var myStruct: RetSingleType
    
    
    init(_ delegate:DetailViewControllerDelegate){
        self.detailViewController = delegate
    }
    
}

