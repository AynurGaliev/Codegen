//
//  StartInteractor.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import RxSwift

protocol IStartInteractor: class {
    var presenter: IStartPresenter! { get set }
    var authService: IAuthService! { get set }
}

final class StartInteractor: IStartInteractor {
    
    weak var presenter: IStartPresenter!
    var authService: IAuthService!
    var disposeBag = DisposeBag()
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) { 
            self.authService.login()
        }
        
        AppDelegate.testAPIRequestWithReactiveExtension(id: "asd")
                   .subscribe(onNext: { (data) in
                    
                   }, onError: { (error: Error) in
                    
                   }, onCompleted: nil, onDisposed: nil)
                   .addDisposableTo(self.disposeBag)
        
    }
}
