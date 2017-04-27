//
// APIRequestUploadSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestUploadSerializer: class {
	func serialize(enAPIRequestUpload: ENAPIRequestUpload?, depth: Int) -> APIRequestUpload?
	func serialize(enAPIRequestUploads: [ENAPIRequestUpload], depth: Int) -> [APIRequestUpload]
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestUploadSerializer: IAPIRequestUploadSerializer {

	//MARK: - Dependencies
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequestUpload: ENAPIRequestUpload?, depth: Int) -> APIRequestUpload? {

		guard let lAPIRequestUpload = enAPIRequestUpload else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let fileID = lAPIRequestUpload.fileID
		let isRequired = lAPIRequestUpload.isRequired

		//MARK: - Serializing relationships
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequestUpload.queue, depth: maxDepth - 1)

		return APIRequestUpload(fileID: fileID, isRequired: isRequired, queue: queue)
	}

	func serialize(enAPIRequestUploads: [ENAPIRequestUpload], depth: Int) -> [APIRequestUpload] {

		guard enAPIRequestUploads.count != 0 else { return [] }
		var serializedAPIRequestUploads: [APIRequestUpload] = []
		for value in enAPIRequestUploads {
			guard let entity = self.serialize(enAPIRequestUpload: value, depth: depth) else { continue }
			serializedAPIRequestUploads.append(entity)
		}
		return serializedAPIRequestUploads
	}
}
