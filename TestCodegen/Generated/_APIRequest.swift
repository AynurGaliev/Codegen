//
// _APIRequest.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequest {

	let isRequired: Bool
	let queue: CaseQueue?

	init(isRequired: Bool, queue: CaseQueue?) {
		self.isRequired = isRequired
		self.queue = queue
	}

	enum Keys {
		static let isRequired: String = "isRequired"
		static let queue: String = "queue"
	}
}

func ==(lhs: APIRequest, rhs: APIRequest) -> Bool {
	return lhs.isRequired == rhs.isRequired && lhs.queue == rhs.queue 
}

func ==(lhs: APIRequest?, rhs: APIRequest?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequest]?, rhs: [APIRequest]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
