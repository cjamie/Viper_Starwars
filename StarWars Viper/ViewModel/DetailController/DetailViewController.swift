//
//  DetailViewController.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, DetailViewControllerDelegate{
//    @IBOutlet weak var myImage: UIImageView!
//    @IBOutlet weak var myLabel: UILabel!
    var detailViewModel: DetailViewModelDelegate?
    
    
    override func viewDidLoad() {
        self.detailViewModel = DetailViewModel(self)
        print("in Detail VDL")
    }
}
