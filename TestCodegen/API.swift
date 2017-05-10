//
//  API.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 6.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Alamofire
import RxSwift
import Foundation

protocol IApi: class {
    func make(request: RequestBuilder) -> Observable<Data>
}

enum APIError: Error {
    case MissingResponse
}

final class API: IApi {
    
    var sessionManager: SessionManager!
    
    func make(request: RequestBuilder) -> Observable<Data> {
        
        return Observable.create { (subscriber) -> Disposable in
            
            self.sessionManager.delegate.taskWillPerformHTTPRedirection = { (session: URLSession, task: URLSessionTask, response: HTTPURLResponse, request: URLRequest) -> URLRequest? in
             
                return nil
            }
            
            let request = self.sessionManager.request(request.url, method: request.method, parameters: request.params, encoding: request.encoding, headers: request.headers)
            request.responseData(completionHandler: { (response: DataResponse<Data>) in
                if let lError = response.error {
                    subscriber.onError(lError)
                }
                if let lData = response.data {
                    subscriber.onNext(lData)
                } else {
                    subscriber.onError(APIError.MissingResponse)
                }
                subscriber.onCompleted()
            })
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
