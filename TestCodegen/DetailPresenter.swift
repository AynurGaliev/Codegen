//
//  DetailPresenter.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

protocol IDetailPresenter: class {
    var view: IDetailView! { get set }
    var interactor: IDetailInteractor! { get set }
    var router: IDetailRouter! { get set }
}

final class DetailPresenter: IDetailPresenter {

    weak var view: IDetailView!
    var interactor: IDetailInteractor!
    var router: IDetailRouter!
}
