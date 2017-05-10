//
//  DetailInteractor.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

protocol IDetailInteractor: class {
    var presenter: IDetailPresenter! { get set }
}

final class DetailInteractor: IDetailInteractor {
    
    var presenter: IDetailPresenter!
}
