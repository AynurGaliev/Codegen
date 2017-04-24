//
// _TWAPIRequest.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWAPIRequest {

	let isRequired: Bool
	let queue: TWCaseQueue?

	init(isRequired: Bool, queue: TWCaseQueue?) {
		self.isRequired = isRequired
		self.queue = queue
	}

	enum Keys {
		static let isRequired: String = "isRequired"
		static let queue: String = "queue"
	}
}

func ==(lhs: TWAPIRequest, rhs: TWAPIRequest) -> Bool {
	return lhs.isRequired == rhs.isRequired && lhs.queue == rhs.queue 
}

func ==(lhs: TWAPIRequest?, rhs: TWAPIRequest?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWAPIRequest]?, rhs: [TWAPIRequest]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
