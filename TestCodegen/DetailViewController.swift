//
//  DetailViewController.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit

typealias ConfigurationBlock = ((UIViewController) -> ())

protocol IDetailView: class {
    var presenter: IDetailPresenter! { get set }
}

protocol IDetailModuleInput: class {
    func prepare(with id: String, callback: ((String) -> ()))
}

final class DetailViewController: UIViewController, IDetailView {

    var presenter: IDetailPresenter!
}

extension DetailViewController: IDetailModuleInput {
    
    func prepare(with id: String, callback: ((String) -> ())) {
        //self.presenter.doSomething()
    }
}

extension DetailViewController: ITransitionHandler {
    
    func performTransition(with id: String, configurationBlock: ConfigurationBlock) {
        self.performSegue(withIdentifier: id, sender: configurationBlock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let configurationBlock = sender as? ConfigurationBlock else { return }
        configurationBlock(segue.destination)
    }
}
