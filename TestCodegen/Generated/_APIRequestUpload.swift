//
// _APIRequestUpload.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequestUpload: _APIRequest {

	let fileID: String

	init(fileID: String, isRequired: Bool, queue: CaseQueue?) {
		self.fileID = fileID
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let fileID: String = "fileID"
	}
}

func ==(lhs: APIRequestUpload, rhs: APIRequestUpload) -> Bool {
	return lhs.fileID == rhs.fileID 
}

func ==(lhs: APIRequestUpload?, rhs: APIRequestUpload?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequestUpload]?, rhs: [APIRequestUpload]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
