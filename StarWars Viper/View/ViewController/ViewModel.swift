//
//  ViewModel.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

class ViewModel {
//    var dataCount: Int?
    var dataArr = [RetSingleType]()
    var viewController: ViewControllerDelegate?
    init(_ delegate:ViewControllerDelegate){
        self.viewController = delegate
    }
}
extension ViewModel: ViewModelDelegate{
    
    func getObject(by index:Int)->RetSingleType{
        return dataArr[index]
    }

    //might need to use an escaping closure so it can be called from tableView
    func getAllObjects(curr:String, completion: @escaping()->() ) {
        Networking.downloadObjects(byPage: curr) {
            [weak self](retStructType, error) in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            guard let tempStruct = retStructType else {return}
            self?.dataArr.append(contentsOf: tempStruct.myArr)
            guard let nextLoad = tempStruct.myNext  else {
                print("all people loaded, reloading table data...")
                guard let copy = self?.dataArr else{return}
//                print(copy)
                print("reloading data")
                self?.viewController?.reloadData()
                //       self.tableView.reloadData()
                return
            }
            print("load next object...")
            self?.getAllObjects(curr: nextLoad, completion: {})
        }
    }
    
    func getObjectNames(for row:Int)->String {
        return self.dataArr.map{$0.name}[row]
        //Return string from array at index
    }
    
    func getObjectArrayCount()->Int {
        return dataArr.count
    }
}

