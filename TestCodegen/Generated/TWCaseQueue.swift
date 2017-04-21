//
// TWCaseQueue.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWCaseQueue {

	let queueCase: TWCase
	let requests: [TWAPIRequest]?

	init(queueCase: TWCase, requests: [TWAPIRequest]?) {
		self.queueCase = queueCase
		self.requests = requests
	}

	enum Keys {
		static let queueCase: String = "queueCase"
		static let requests: String = "requests"
	}
}

func ==(lhs: TWCaseQueue, rhs: TWCaseQueue) -> Bool {
	return lhs.queueCase == rhs.queueCase && lhs.requests == rhs.requests 
}

func ==(lhs: TWCaseQueue?, rhs: TWCaseQueue?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWCaseQueue]?, rhs: [TWCaseQueue]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
