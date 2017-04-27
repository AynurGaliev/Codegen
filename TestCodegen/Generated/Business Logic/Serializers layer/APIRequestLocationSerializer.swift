//
// APIRequestLocationSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestLocationSerializer: class {
	func serialize(enAPIRequestLocation: ENAPIRequestLocation?, depth: Int) -> APIRequestLocation?
	func serialize(enAPIRequestLocations: [ENAPIRequestLocation], depth: Int) -> [APIRequestLocation]
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestLocationSerializer: IAPIRequestLocationSerializer {

	//MARK: - Dependencies
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequestLocation: ENAPIRequestLocation?, depth: Int) -> APIRequestLocation? {

		guard let lAPIRequestLocation = enAPIRequestLocation else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lAPIRequestLocation.createdAt
		let isRequired = lAPIRequestLocation.isRequired
		let latitude = lAPIRequestLocation.latitude
		let longitude = lAPIRequestLocation.longitude

		//MARK: - Serializing relationships
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequestLocation.queue, depth: maxDepth - 1)

		return APIRequestLocation(createdAt: createdAt, isRequired: isRequired, latitude: latitude, longitude: longitude, queue: queue)
	}

	func serialize(enAPIRequestLocations: [ENAPIRequestLocation], depth: Int) -> [APIRequestLocation] {

		guard enAPIRequestLocations.count != 0 else { return [] }
		var serializedAPIRequestLocations: [APIRequestLocation] = []
		for value in enAPIRequestLocations {
			guard let entity = self.serialize(enAPIRequestLocation: value, depth: depth) else { continue }
			serializedAPIRequestLocations.append(entity)
		}
		return serializedAPIRequestLocations
	}
}
