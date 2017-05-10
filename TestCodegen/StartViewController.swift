//
//  ViewController.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 21.04.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

protocol IStartView: class {
    var presenter: IStartPresenter! { get set }
}

protocol ITransitionHandler: class {
    func performTransition(with id: String, configurationBlock: ConfigurationBlock)
}

final class StartViewController: UIViewController, IStartView {
    
    var presenter: IStartPresenter!
}

extension StartViewController: ITransitionHandler {
    
    func performTransition(with id: String, configurationBlock: ConfigurationBlock) {
        self.performSegue(withIdentifier: id, sender: configurationBlock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let configurationBlock = sender as? ConfigurationBlock else { return }
        configurationBlock(segue.destination)
    }
}

