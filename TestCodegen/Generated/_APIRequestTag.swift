//
// _APIRequestTag.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequestTag: _APIRequest {

	let enabled: Bool
	let tagID: String

	init(enabled: Bool, isRequired: Bool, queue: CaseQueue?, tagID: String) {
		self.enabled = enabled
		self.tagID = tagID
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let enabled: String = "enabled"
		static let tagID: String = "tagID"
	}
}

func ==(lhs: APIRequestTag, rhs: APIRequestTag) -> Bool {
	return lhs.enabled == rhs.enabled && lhs.tagID == rhs.tagID 
}

func ==(lhs: APIRequestTag?, rhs: APIRequestTag?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequestTag]?, rhs: [APIRequestTag]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
