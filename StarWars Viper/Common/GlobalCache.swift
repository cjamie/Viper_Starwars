//
//  GlobalCache.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit


class GlobalCache{
    static let shared = GlobalCache()
    var imgCache = ImageCache()


}

class ImageCache:NSCache<NSString, UIImage>{
    
    var maxSize = Int.max
    
    override var totalCostLimit:Int {
        get{
            return maxSize
        }
        set {
            maxSize = newValue
        }
    }
}
