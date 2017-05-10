//
//  ServiceModule.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

final class ServiceModule {
    
    static var shared: ServiceModule = ServiceModule()
    
    var networkModule = NetworkModule.shared
    
    func authService() -> IAuthService {
        let authService = AuthService()
        authService.transport = self.networkModule.authTransport()
        return authService
    }
}
