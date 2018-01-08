//
//  CustomObjectCell.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit



class CustomObjectCell: UITableViewCell{
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var names = [String]()
    
    func loadObjectImage(fromName name:String, type: RetSingleType){
        if let image = GlobalCache.shared.imgCache.object(forKey:name as NSString){
            self.myImage.image = image
            return
        }
        
        Networking.downloadImage(type: type, completion: { (image, error) in
            guard error == nil else {return}
            guard let image = image else{return}
            GlobalCache.shared.imgCache.setObject(image,forKey: name as NSString)
            DispatchQueue.main.async {
                self.myImage.image = image
            }
        })
    }
}



