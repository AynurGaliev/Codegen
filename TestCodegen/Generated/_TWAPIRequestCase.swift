//
// _TWAPIRequestCase.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWAPIRequestCase: _TWAPIRequest {

	let parameters: NSDictionary

	init(isRequired: Bool, parameters: NSDictionary, queue: TWCaseQueue?) {
		self.parameters = parameters
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let parameters: String = "parameters"
	}
}

func ==(lhs: TWAPIRequestCase, rhs: TWAPIRequestCase) -> Bool {
	return lhs.parameters == rhs.parameters 
}

func ==(lhs: TWAPIRequestCase?, rhs: TWAPIRequestCase?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWAPIRequestCase]?, rhs: [TWAPIRequestCase]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
