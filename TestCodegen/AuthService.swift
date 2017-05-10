//
//  AuthService.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

protocol IAuthService: class {
    var transport: IAuthTransport! { get set }
    func login()
}

final class AuthService: IAuthService {
    
    var transport: IAuthTransport!
    
    func login() {
        self.transport.login()
    }
}
