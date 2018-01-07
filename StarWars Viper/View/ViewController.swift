//
//  ViewController.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit
/*
 -sole responsibility is to display what the Presenter tells it to
 -when user triggers an event that requires processing, the view delegates it to the presenter and awaits a response telling it what it should display next
 */


//class-bound protocol to define my view methods
protocol ViewControllerInterface: class {
    //    func showCellImages()
    //    func showCellNames()
    
}

class ViewController: UIViewController, ViewControllerInterface {
    //has a strong reference to the presenter
    var presenter: ObjectViewModule!
    
    //once it has loaded, it will send a request to presenter to load the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VDL n")
        //        self.presenter.updateView()
        loadAllObjects(curr: "https://swapi.co/api/planets")
    }

    var dataArr = [RetSingleType]()
    
    func loadAllObjects(curr:String){
        print("loadAll")
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
                print(copy)
                //                    self.tableView.reloadData()
                return
            }
            print("next load object")
            self?.loadAllObjects(curr: nextLoad)
        }
    }
}

