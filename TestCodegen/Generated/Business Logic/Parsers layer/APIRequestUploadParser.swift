//
// APIRequestUploadParser.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestUploadParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestUpload
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestUpload]
}

final class APIRequestUploadParser: IAPIRequestUploadParser {

	//MARK: - Dependencies

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestUpload {

		let enAPIRequestUpload: ENAPIRequestUpload = ENAPIRequestUpload()

		//MARK: - Parsing attributes
		enAPIRequestUpload.fileID = try json.value(by: "fileID")

		return enAPIRequestUpload
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestUpload] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequestUploads: [ENAPIRequestUpload] = []
		for json in jsonArray {
			let enAPIRequestUpload: ENAPIRequestUpload = try self.serialize(json: json)
			enAPIRequestUploads.append(enAPIRequestUpload)
		}
		return enAPIRequestUploads
	}

}
