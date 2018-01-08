//
//  ViewModel.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation





//My view controller just wants my object array.count, the images, and names.




class ViewModel {
//    var dataCount: Int?
    
    var dataArr: [RetSingleType]?
    
    
    var viewController: ViewControllerDelegate?

    init(_ delegate:ViewControllerDelegate){
        self.viewController = delegate
        
    }

//    var dataArr:[RetSingleType]=[]
    
   /* private var dataArr:[RetSingleType]
    
    //computed properties that are get-only by default
    var dataCount: Int{
        return dataArr.count
    }

    var selectedObject: RetSingleType?{
        viewController
    }
    
    var names:[String]{
        return dataArr.map{$0.name}
    }*/
}
extension ViewModel: ViewModelDelegate{
    func getObjects() {
        //Make Network call to store data
    }
    
    func getObjectName() {
        //Return string from array at index
    }
    
    func getObjectArrayCount() {
        //Return count of array
    }
    

}

