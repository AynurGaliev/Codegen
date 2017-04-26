//
// _APIRequestLocation.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequestLocation: _APIRequest {

	let createdAt: Date
	let latitude: Double
	let longitude: Double

	init(createdAt: Date, isRequired: Bool, latitude: Double, longitude: Double, queue: CaseQueue?) {
		self.createdAt = createdAt
		self.latitude = latitude
		self.longitude = longitude
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let createdAt: String = "createdAt"
		static let latitude: String = "latitude"
		static let longitude: String = "longitude"
	}
}

func ==(lhs: APIRequestLocation, rhs: APIRequestLocation) -> Bool {
	return lhs.createdAt == rhs.createdAt && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude 
}

func ==(lhs: APIRequestLocation?, rhs: APIRequestLocation?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequestLocation]?, rhs: [APIRequestLocation]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
