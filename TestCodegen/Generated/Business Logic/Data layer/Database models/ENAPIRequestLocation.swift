//
// ENAPIRequestLocation.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENAPIRequestLocation: ENAPIRequest {

	//MARK: - Attributes
	dynamic var createdAt: Date = Date()
	dynamic var latitude: Double = 0.0
	dynamic var longitude: Double = 0.0

}
