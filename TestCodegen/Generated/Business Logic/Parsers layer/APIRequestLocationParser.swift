//
// APIRequestLocationParser.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestLocationParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestLocation
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestLocation]
}

final class APIRequestLocationParser: IAPIRequestLocationParser {

	//MARK: - Dependencies

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestLocation {

		let enAPIRequestLocation: ENAPIRequestLocation = ENAPIRequestLocation()

		//MARK: - Parsing attributes
		enAPIRequestLocation.createdAt = try json.value(by: "createdAt")
		enAPIRequestLocation.latitude = try json.value(by: "latitude")
		enAPIRequestLocation.longitude = try json.value(by: "longitude")

		return enAPIRequestLocation
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestLocation] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequestLocations: [ENAPIRequestLocation] = []
		for json in jsonArray {
			let enAPIRequestLocation: ENAPIRequestLocation = try self.serialize(json: json)
			enAPIRequestLocations.append(enAPIRequestLocation)
		}
		return enAPIRequestLocations
	}

}
