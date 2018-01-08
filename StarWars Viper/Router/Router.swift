//
//  Router.swift
//  StarWars Viper
//
//  Created by Admin on 1/7/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import UIKit

/*
 navigation logic of the application
 defines the possible routes
 */

protocol WireframeInput {
//    func presentDetailsInterfaceForArticle(article: Article)
}

//other alternative name is WireFrame
//responsible for navigation between modules
class Router: NSObject, WireframeInput{

    static var mainStoryboard: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
