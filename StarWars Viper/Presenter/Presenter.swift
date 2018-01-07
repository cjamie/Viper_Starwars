//
//  Presenter.swift
//  StarWars Viper
//
//  Created by Admin on 1/6/18.
//  Copyright © 2018 Jamie Chu. All rights reserved.
//

import Foundation

//protocol that defines my commands sent from (view -> presenter)
protocol ObjectViewModule:class{
    func updateView()
}
//protocol that defines (interactor->Presenter)
protocol ObjectInteractorOutput:class{
    func objectsFetched(objects: [RetStructType])
}


class ObjectPresenter: ObjectViewModule{
    //1) Weak reference to the View
    weak var view: ViewControllerInterface!
    
    //2) Strong reference to the Interactor interface
    var interactor: InteractorInput!
    
    //3) Reference to the wireframe
    var router: Router!

    func updateView() {
//        self.interactor.updateView()
    }
    
    
}


