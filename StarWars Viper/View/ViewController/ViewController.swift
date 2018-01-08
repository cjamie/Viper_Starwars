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
    //String reference to viewModel because you "own" it
//    lazy var viewModel: ViewModel = ViewModel(self)
    var viewModel: ViewModelDelegate?

//    init(_ delegate:ViewModelDelegate){
//        self.viewModel = delegate
//    }

    var dataArr = [RetSingleType]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //once it has loaded, it will send a request to presenter to load the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("VDL n")
        //        self.presenter.updateView()
        self.viewModel = ViewModel(self)
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

//typealias VCInterfaceFunctions = ViewController
//extension VCInterfaceFunctions: ViewControllerDelegate{
//
//    //takes in [String] and displays onto the table view
//    func showCellNames(data:[RetSingleType]) {
//        self.dataArr = data
//        self.tableView.reloadData()
//    }
//
//}



typealias privateTableViewFunctions = ViewController
extension privateTableViewFunctions: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
        //Unwrap ViewModel
        //return ViewModel.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customObjectCell") as? CustomObjectCell else {
            fatalError("No cell in tableView")
//            return UITableViewCell
        }
        //let name = ViewModel.getObjectName()
        //cell.label?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: instantiate your detail view controller. depenceny injection.
        
    }
}

extension ViewController:ViewControllerDelegate{
    func reloadData() {
        
    }
    
    
}
