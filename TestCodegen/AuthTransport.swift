//
//  AuthTransport.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Alamofire
import RxSwift

protocol IAuthTransport: class {
    var api: IApi! { get set }
    func login()
}

final class AuthTransport: IAuthTransport {
    
    var api: IApi!
    var disposeBag = DisposeBag()
    
    func login() {
        self.api.make(request: Router.Auth.authorize(client_id)).subscribe().addDisposableTo(self.disposeBag)
    }
    
}
