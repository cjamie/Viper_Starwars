//
//  DetailViewController.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, DetailViewControllerDelegate{

    @IBOutlet weak var detailLabel1: UILabel!
    @IBOutlet weak var detailLabel2: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var detailViewModel: DetailViewModelDelegate?

    override func viewDidLoad() {
        self.detailViewModel = DetailViewModel(self)
        print("in Detail VDL")
    }
}
