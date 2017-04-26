//
// _APIRequestChat.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequestChat: _APIRequest {

	let parameters: Data

	init(isRequired: Bool, parameters: Data, queue: CaseQueue?) {
		self.parameters = parameters
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let parameters: String = "parameters"
	}
}

func ==(lhs: APIRequestChat, rhs: APIRequestChat) -> Bool {
	return lhs.parameters == rhs.parameters 
}

func ==(lhs: APIRequestChat?, rhs: APIRequestChat?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequestChat]?, rhs: [APIRequestChat]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
