//
//  ViewControllerConfigurator.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

final class StartAssembly: NSObject {

    @IBOutlet weak var controller: StartViewController!
    var serviceModule: ServiceModule = ServiceModule.shared
    
    override func awakeFromNib() {
        
        let presenter = self.presenter()
        let interactor = self.interactor()
        let router = self.router()

        interactor?.presenter = presenter
        presenter?.interactor = interactor
        router?.transitionHandler = controller
        presenter?.router = router
        self.controller.presenter = presenter
    }
    
    func presenter() -> IStartPresenter! {
        return StartPresenter()
    }
    
    func router() -> IStartRouter! {
        return StartRouter()
    }
    
    func interactor() -> IStartInteractor! {
        let interactor = StartInteractor()
        interactor.authService = self.serviceModule.authService()
        return interactor
    }
}
