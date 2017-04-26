//
// _CaseQueue.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _CaseQueue {

	let queueCase: Case
	let requests: [APIRequest]?

	init(queueCase: Case, requests: [APIRequest]?) {
		self.queueCase = queueCase
		self.requests = requests
	}

	enum Keys {
		static let queueCase: String = "queueCase"
		static let requests: String = "requests"
	}
}

func ==(lhs: CaseQueue, rhs: CaseQueue) -> Bool {
	return lhs.queueCase == rhs.queueCase && lhs.requests == rhs.requests 
}

func ==(lhs: CaseQueue?, rhs: CaseQueue?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [CaseQueue]?, rhs: [CaseQueue]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
