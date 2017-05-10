//
//  StartRouter.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import UIKit

protocol IStartRouter: class {
    var transitionHandler: ITransitionHandler! { get set }
    var presenter: IStartPresenter! { get set }
    func navigateToDetails(id: String)
}

enum StartScreenNavigation: String {
    case Details = ""
}

final class StartRouter: IStartRouter {
    
    weak var transitionHandler: ITransitionHandler!
    weak var presenter: IStartPresenter!
    
    func navigateToDetails(id: String) {
        self.transitionHandler.performTransition(with: StartScreenNavigation.Details.rawValue) { (controller: UIViewController) in
            guard let detailsInput = controller as? IDetailModuleInput else { return }
            detailsInput.prepare(with: id, callback: { (text) in
                //self.presenter.doSomething()
            })
        }
    }
}
