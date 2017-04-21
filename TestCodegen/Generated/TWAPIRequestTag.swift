//
// TWAPIRequestTag.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWAPIRequestTag: TWAPIRequest {

	let enabled: Bool
	let tagID: String

	init(enabled: Bool, isRequired: Bool, queue: TWCaseQueue?, tagID: String) {
		self.enabled = enabled
		self.tagID = tagID
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let enabled: String = "enabled"
		static let tagID: String = "tagID"
	}
}

func ==(lhs: TWAPIRequestTag, rhs: TWAPIRequestTag) -> Bool {
	return lhs.enabled == rhs.enabled && lhs.tagID == rhs.tagID 
}

func ==(lhs: TWAPIRequestTag?, rhs: TWAPIRequestTag?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWAPIRequestTag]?, rhs: [TWAPIRequestTag]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
