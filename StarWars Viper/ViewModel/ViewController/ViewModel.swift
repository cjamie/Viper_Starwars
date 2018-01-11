//
//  ViewModel.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation


//has a reference to its delegate
//we can "inject" different viewModelDelegates based on our needs
class ViewModel {
    var dataArr = [RetSingleType]()
    var viewController: ViewControllerDelegate?
    init(_ delegate:ViewControllerDelegate){
        self.viewController = delegate
    }
}


//we use enum functions and properties to avoid switch statements.

extension ViewModel: ViewModelDelegate{
    //clear your array first
    func changeDataArr(with url: String) {
        self.dataArr = []
        getAllObjects(curr: url) {
        }
    }
    
    
    func getObject(by index:Int)->RetSingleType{
        return dataArr[index]
    }

    //might need to use an escaping closure so it can be called from tableView
    func getAllObjects(curr:String, completion: @escaping()->() ) {
        //clear your array first
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
                print("reloading data from viewModel")
                self?.viewController?.reloadData()
                return
            }
            print("load next object...")
            self?.getAllObjects(curr: nextLoad, completion: {})
            
        }
    }

    
    func getObjectNames(for row:Int)->String {
        return self.dataArr[row].name
    }
    
    func getObjectArrayCount()->Int {
        return dataArr.count
    }
    
    
    

    //neat trick for generating dynamic URL for networking function.
    //reference:https://code.tutsplus.com/tutorials/put-your-view-controllers-on-a-diet-with-mvvm--cms-29473
    
//    enum API{
//        static let baseURL = URL(string: Constants.kUrlPrefix)
//        static var requestURL: URL{
//            return baseURL?.appendingPathComponent(title.lowercased())
//        }
//    }
//
    
    func generateLoadUrl(with title:String)->String{
        print("generate load url \(Constants.kUrlPrefix + title.lowercased())")
        return Constants.kUrlPrefix + title.lowercased()
    }

    func clearDataArr(){
        self.dataArr = []

    }
    

}




