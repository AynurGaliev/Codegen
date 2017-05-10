//
//  File.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

protocol IStartPresenter: class {
    var view: IStartView! { get set }
    var router: IStartRouter! { get set }
    var interactor: IStartInteractor! { get set }
}

final class StartPresenter: IStartPresenter {
    
    weak var view: IStartView!
    var router: IStartRouter!
    var interactor: IStartInteractor!
    
    func goToDetails(with id: String) {
        self.router.navigateToDetails(id: id)
    }
}
