//
//  AppDelegate.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 21.04.17.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let MAX_SERIALIZATION_DEPTH: Int = 3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        return window
    }()
    
    var disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.test()
        
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartViewController")
        self.window?.rootViewController = controller
        return true
    }
    
    func test() {
        
        let intObservable = Observable<Int>.from([1,2,3,4,5])
        let stringObservable = Observable<String>.from(["a", "b", "c"])
        
        let result = Observable<String>.combineLatest(intObservable, stringObservable) { (intValue, stringValue) -> String in
            return stringValue + "\(intValue)"
        }
        
        result.subscribe(onNext: { (s) in
            print(s)
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(self.disposeBag)
    }
    
    class func testAPIRequest(id: String, onSuccess: @escaping ((Data)->()), onFailure: @escaping ((Error)->())) {
        
        let task = URLSession.shared.dataTask(with: URL(string: "")!) { (data: Data?, response: URLResponse?, error: Error?) in
            if let lError = error {
                onFailure(lError)
            } else {
                onSuccess(data!)
            }
        }
        task.resume()
    }
    
    class func testReactiveAPIRequest(id: String) -> Observable<Data> {
        
        return Observable<Data>.create({ (subscriber) -> Disposable in
            
            let task = URLSession.shared.dataTask(with: URL(string: "")!) { (data: Data?, response: URLResponse?, error: Error?) in
                if let lError = error {
                    subscriber.onError(lError)
                } else {
                    subscriber.onNext(data!)
                }
                subscriber.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        })
    }
    
    class func testAPIRequestWithReactiveExtension(id: String) -> Observable<Data> {
        return URLSession.shared.rx.data(request: URLRequest(url: URL(string: "")!))
    }
}
