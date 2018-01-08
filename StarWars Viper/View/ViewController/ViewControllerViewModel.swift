//
//  ViewModel.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation





//My view controller just wants my object array.count, the images, and names.




class ViewModel:ViewModelDelegate {
    
    weak var viewController: ViewModelDelegate!

    init(_ delegate:ViewModelDelegate){
        self.viewController = delegate
        
    }

    var dataArr:[RetSingleType]=[]
    
    private var dataArr:[RetSingleType]{
        self.dataCount = dataArr.count
    }
    
    //computed properties that are get-only by default
    var dataCount: Int{
        return dataArr.count
    }

    var selectedObject: RetSingleType?{
        return obj
    }
    
    var names:[String]{
        return dataArr.map{$0.name}
    }
}


