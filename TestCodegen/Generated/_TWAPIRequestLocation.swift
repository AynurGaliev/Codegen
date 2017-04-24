//
// _TWAPIRequestLocation.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWAPIRequestLocation: _TWAPIRequest {

	let createdAt: Date
	let latitude: Double
	let longitude: Double

	init(createdAt: Date, isRequired: Bool, latitude: Double, longitude: Double, queue: TWCaseQueue?) {
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

func ==(lhs: TWAPIRequestLocation, rhs: TWAPIRequestLocation) -> Bool {
	return lhs.createdAt == rhs.createdAt && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude 
}

func ==(lhs: TWAPIRequestLocation?, rhs: TWAPIRequestLocation?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWAPIRequestLocation]?, rhs: [TWAPIRequestLocation]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
