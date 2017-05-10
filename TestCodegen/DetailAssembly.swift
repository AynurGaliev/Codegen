//
//  DetailAssemble.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

final class DetailAssembly: NSObject {
    
    @IBOutlet weak var controller: DetailViewController!
    
    override func awakeFromNib() {
        let presenter = self.presenter()
        let interactor = self.interactor()
        let router = self.router()
        
        presenter?.interactor = interactor
        interactor?.presenter = presenter
        presenter?.router = router
       
    }
    
    func presenter() -> IDetailPresenter! {
        return DetailPresenter()
    }
    
    func interactor() -> IDetailInteractor! {
        return DetailInteractor()
    }
    
    func router() -> IDetailRouter! {
        return DetailRouter()
    }
}
