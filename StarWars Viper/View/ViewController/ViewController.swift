//
//  ViewController.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit
/*
 -display what the Presenter tells it to
 -passes user events to the presenter
 */

//class-bound protocol to define my view input methods
protocol ViewControllerInterface: class {
    func showCellNames(data:[RetSingleType])
}


class ViewController: UIViewController{
    //has a strong reference to the presenter
//    var presenter: ObjectViewModule?

    @IBOutlet weak var tableView: UITableView!
    
    //once it has loaded, it will send a request to presenter to load the view.
    override func viewDidLoad() {
        super.viewDidLoad()
//        let viewModel = ViewControllerViewModel(dataArr: <#T##[RetSingleType]#>, object: <#T##RetSingleType#>)
        
        print("VDL n")
        //        self.presenter.updateView()
        loadAllObjects(curr: "https://swapi.co/api/planets")
    }
    
    
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

typealias VCInterfaceFunctions = ViewController
extension VCInterfaceFunctions: ViewControllerDelegate{
    
    //takes in [String] and displays onto the table view
    func showCellNames(data:[RetSingleType]) {
        self.dataArr = data
        self.tableView.reloadData()
    }
    
}



typealias privateTableViewFunctions = ViewController
extension privateTableViewFunctions: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customObjectCell") as? CustomObjectCell else {
            fatalError("No cell in tableView")
//            return UITableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: instantiate your detail view controller. depenceny injection.
        
    }
}


