//
// FileParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IFileParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENFile
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENFile]
	var caseParser: ICaseParser! { get set }
}

final class FileParser: IFileParser {

	//MARK: - Dependencies
	var caseParser: ICaseParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENFile {

		let enFile: ENFile = ENFile()

		//MARK: - Parsing attributes
		enFile.data = try json.value(by: "data")
		enFile.deviceCreatedAt = try json.value(by: "deviceCreatedAt")
		enFile.id = try json.value(by: "id")
		enFile.type = try json.value(by: "type")

		//MARK: - One-to-one relationships parsing
		enFile.userCase = try self.caseParser.serialize(json: json.value(by: "userCase"))

		return enFile
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENFile] {
		guard jsonArray.count > 0 else { return [] }
		var enFiles: [ENFile] = []
		for json in jsonArray {
			let enFile: ENFile = try self.serialize(json: json)
			enFiles.append(enFile)
		}
		return enFiles
	}

}
