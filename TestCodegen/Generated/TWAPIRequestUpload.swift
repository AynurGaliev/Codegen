//
// TWAPIRequestUpload.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

final class TWAPIRequestUpload: TWAPIRequest {

	let fileID: String

	init(fileID: String, isRequired: Bool, queue: TWCaseQueue?) {
		self.fileID = fileID
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let fileID: String = "fileID"
	}
}

func ==(lhs: TWAPIRequestUpload, rhs: TWAPIRequestUpload) -> Bool {
	return lhs.fileID == rhs.fileID 
}

func ==(lhs: TWAPIRequestUpload?, rhs: TWAPIRequestUpload?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWAPIRequestUpload]?, rhs: [TWAPIRequestUpload]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
