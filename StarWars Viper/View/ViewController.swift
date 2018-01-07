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
        print("VDL")
//        self.presenter.updateView()
        loadAllPeople(curr: "https://swapi.co/api/planets")
    }
    
    
    
    
    
    
    
    var peopleArr = [Person]()
    var planetArr = [Planet]()
    var starshipArr = [Starship]()
    var vehicleArr = [Vehicle]()
    var filmArr = [Film]()
    var specieArr = [Specie]()
    
    
    func loadAllPeople(curr:String){
        print("loadAll")
        Networking.downloadObjects(byPage: curr) {
            [weak self](retStructType, error) in
            guard error == nil else{
                print(error!)
                return}
            guard let tempStruct = retStructType else {return}
            switch tempStruct{
            case let .People1(x):
                self?.peopleArr.append(contentsOf: x.results.map{$0})
                guard let nextLoad = x.next else {
                    print("all people loaded, reloading table data...")
                    //                    self.tableView.reloadData()
                    return}
                print("next load people")
                self?.loadAllPeople(curr: nextLoad)
            case let .Planets1(x):
                
                self?.planetArr.append(contentsOf: x.results.map{$0})
                guard let nextLoad = x.next else {
                    print("all planets loaded, reloading data...")
//                    self.tableView.reloadData()
                    return}
                print("next load")
                self?.loadAllPeople(curr: nextLoad)

            case let .Starships1(x):
                self?.starshipArr.append(contentsOf: x.results.map{$0})
            case let .Vehicles1(x):
                self?.vehicleArr.append(contentsOf: x.results.map{$0})
            case let .Films1(x):
                self?.filmArr.append(contentsOf: x.results.map{$0})
            case let .Species1(x):
                self?.specieArr.append(contentsOf: x.results.map{$0})
            }
        }
    }
}

