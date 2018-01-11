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

class ViewController: UIViewController{
    var viewModel: ViewModelDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    //once it has loaded, it will send a request to presenter to load the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("VDL n")
        self.viewModel = ViewModel(self) //closes the loop
        viewModel?.getAllObjects(curr: "https://swapi.co/api/people", completion: {})
        
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
        performSegue(withIdentifier: "toDetailView", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //should probably move this to VM. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing for segue")
        //        if segue.identifier == "friendsToAddFriend",
        //            let destinationViewController = segue.destination as? FriendViewController {
        //            destinationViewController.viewModel = AddFriendViewModel()
        //            destinationViewController.updateFriends = { [weak self] in
        //                self?.viewModel.getFriends()
        //            }
        //        }
        
        guard let detailVC = segue.destination as? DetailViewController else {return}
        detailVC.detailViewModel = DetailViewModel(detailVC)
        detailVC.updateMyObject = {
            [weak self] in
            guard let tempIndex = self?.tableView.indexPathForSelectedRow?.row else {return}
            
            guard let tempObj = self?.viewModel?.getObject(by: tempIndex) else {return}
            print("row selected")
            detailVC.detailViewModel?.setObject(tempObj)
        }
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
    //TODO: reload data only when current title changes. 
    func tabBar(_ tabBar2: UITabBar, didSelect item: UITabBarItem) {
//        print("current title is: \(tabBar.selectedItem?.title ?? "")")
//        print("current title is: \(tabBar2.selectedItem?.title ?? "")")

        guard let itemTitle = item.title else{return}
        guard let tempURL = self.viewModel?.generateLoadUrl(with: itemTitle) else{return}
        self.viewModel?.changeDataArr(with: tempURL)
//        print("current title is: \(tabBar.selectedItem?.title ?? "")")
//        print("current title now: \(tabBar2.selectedItem?.title ?? "")")
    }
}
