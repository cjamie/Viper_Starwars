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
    var viewModel: ViewModelDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    //once it has loaded, it will send a request to presenter to load the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("VDL n")
        self.viewModel = ViewModel(self) //closes the loop
//        viewModel?.getAllObjects(curr: "https://swapi.co/api/planets")
        viewModel?.getAllObjects(curr: "https://swapi.co/api/starships", completion: {
//            self.reloadData()
        })
    }
    
    
}



typealias privateTableViewFunctions = ViewController
extension privateTableViewFunctions: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let tempCount = viewModel?.getObjectArrayCount() else{return 0}
        return tempCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customObjectCell") as? CustomObjectCell else {
            fatalError("No cell in tableView")
//            return UITableViewCell
        }
        
        print("inTableViewCell")
        guard let currName = viewModel?.getObjectNames(for: indexPath.row) else {fatalError("No cell in tableView")}
        guard let currObject = viewModel?.getObject(by: indexPath.row) else {fatalError("No cell in tableView")}
        cell.backgroundColor = UIColor.cyan
        cell.loadObjectImage(fromName: currName, type: currObject)
        cell.labelText.text = viewModel?.getObjectNames(for: indexPath.row)
        return cell
    }

    //segue to details view controller.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: instantiate your detail view controller. dependency injection.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController:ViewControllerDelegate{
    func reloadData() {
        print("reloading table data")
        self.tableView.reloadData()
    }
}

typealias TabBarFunctions = ViewController
extension TabBarFunctions: UITabBarDelegate{
    //reload the tableview with new viewmodel content.
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tempURL = self.viewModel?.generateLoadUrl(with: item.title!) else{return}
        self.viewModel?.changeDataArr(with: tempURL)
//        viewModel?.getAllObjects(curr: tempURL, completion: {
//            print("tabBar call complete")
//            self.reloadData()
//        })
        //        self.viewModel?.changeDataArr(to: )
        
//        print(item.title)
    }
}
