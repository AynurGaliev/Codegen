//
// ENTWAPIRequest.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

class ENTWAPIRequest: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var isRequired: Bool = false

	//MARK: - One-to-one relationships
	dynamic var queue: ENTWCaseQueue?

}
