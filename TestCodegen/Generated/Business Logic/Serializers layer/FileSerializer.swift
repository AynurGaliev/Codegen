//
// FileSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IFileSerializer: class {
	func serialize(enFile: ENFile?, depth: Int) -> File?
	func serialize(enFiles: [ENFile], depth: Int) -> [File]
	var caseSerializer: ICaseSerializer! { get set }
}

final class FileSerializer: IFileSerializer {

	//MARK: - Dependencies
	var caseSerializer: ICaseSerializer!

	func serialize(enFile: ENFile?, depth: Int) -> File? {

		guard let lFile = enFile else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lFile.createdAt
		let data = lFile.data
		let deviceCreatedAt = lFile.deviceCreatedAt
		let id = lFile.id
		let localUpdatedAt = lFile.localUpdatedAt
		let type = lFile.type
		let updatedAt = lFile.updatedAt

		//MARK: - Serializing relationships
		let userCase = self.caseSerializer.serialize(enCase: lFile.userCase, depth: maxDepth - 1)!

		return File(createdAt: createdAt, data: data, deviceCreatedAt: deviceCreatedAt, id: id, localUpdatedAt: localUpdatedAt, type: type, updatedAt: updatedAt, userCase: userCase)
	}

	func serialize(enFiles: [ENFile], depth: Int) -> [File] {

		guard enFiles.count != 0 else { return [] }
		var serializedFiles: [File] = []
		for value in enFiles {
			guard let entity = self.serialize(enFile: value, depth: depth) else { continue }
			serializedFiles.append(entity)
		}
		return serializedFiles
	}
}
