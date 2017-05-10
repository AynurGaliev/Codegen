//
//  NetworkModule.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkModule {
    
    static var shared: NetworkModule = NetworkModule()
    
    //MARK: - Singletons
    private var api: IApi! = {
        let api = API()
        api.sessionManager = SessionManager.default
        return api
    }()
    
    func getAPI() -> IApi! {
        return self.api
    }
    
    func authTransport() -> IAuthTransport {
        let transport = AuthTransport()
        transport.api = self.getAPI()
        return transport
    }
}
