//
//  Presenter.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation
/*
 receives data structures from the interactor and applies view logic to this data to prepare it for the view
 
 */


//defines commands sent from (view -> presenter)
protocol ObjectViewModule:class{
    func updateView()
}
//defines commands sent from (interactor->Presenter)
protocol ObjectInteractorOutput:class{
    func objectsFetched(objects: [RetStructType])
}

class ObjectPresenter: ObjectViewModule{
    //1) Weak reference to the View
    //2) Strong reference to the Interactor interface
    //3) Reference to the wireframe
//    weak var view: ViewControllerInterface?
    var interactor: InteractorInput?
    var router: Router?

    
    //will return my objects
    func updateView() {
         self.interactor?.fetchObjects()
    }
}


