//
// _APIRequestCase.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequestCase: _APIRequest {

	let parameters: Data

	init(isRequired: Bool, parameters: Data, queue: CaseQueue?) {
		self.parameters = parameters
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let parameters: String = "parameters"
	}
}

func ==(lhs: APIRequestCase, rhs: APIRequestCase) -> Bool {
	return lhs.parameters == rhs.parameters 
}

func ==(lhs: APIRequestCase?, rhs: APIRequestCase?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequestCase]?, rhs: [APIRequestCase]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
