//
//  DetailRouter.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import UIKit

protocol IDetailRouter: class {
    var transitionHandler: ITransitionHandler! { get set }
    func showConversation()
}

final class DetailRouter: IDetailRouter {
    
    weak var transitionHandler: ITransitionHandler!
    
    func showConversation() {
        self.transitionHandler.performTransition(with: "") { (controller: UIViewController) in
            
        }
    }
}
