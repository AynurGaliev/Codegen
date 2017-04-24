//
// ENAPIRequest.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

class ENAPIRequest: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var isRequired: Bool = false

	//MARK: - Relationships
	dynamic var queue: ENCaseQueue?

}
