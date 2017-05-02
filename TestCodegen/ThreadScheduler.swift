//
//  ThreadScheduler.swift
//  TestCodegen
//
//  Created by Aynur Galiev on 2.мая.2017.
//  Copyright © 2017 Aynur Galiev. All rights reserved.
//

import Foundation

typealias Callback = (() -> ())

final class ThreadScheduler {
    
    private let thread: Thread
    private let target: ThreadTarget
    
    init(threadName: String) {
        self.target = ThreadTarget()
        self.thread = Thread(target: self.target,
                           selector: #selector(ThreadTarget.threadEntryPoint),
                             object: nil)
        self.thread.name = threadName
        self.thread.start()
    }
    
    func perform(async: Bool = true, block: @escaping Callback) {
        let action: Action = Action(action: block)
        action.perform(#selector(action.performAction), on: self.thread, with: nil, waitUntilDone: !async)
    }
    
    func destroy() {
        self.thread.cancel()
    }
    
    deinit {
        self.thread.cancel()
    }
}

private final class ThreadTarget: NSObject {
    
    @objc fileprivate func threadEntryPoint() {
        let runLoop = RunLoop.current
        runLoop.add(NSMachPort(), forMode: RunLoopMode.defaultRunLoopMode)
        runLoop.run()
    }
}

private final class Action: NSObject {
    
    private let action: Callback
    
    init(action: @escaping Callback) {
        self.action = action
    }
    
    @objc func performAction() {
        self.action()
    }
}
