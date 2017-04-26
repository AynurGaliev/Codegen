//
// ENObject.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

class ENObject: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var createdAt: Date = Date()
	dynamic var localUpdatedAt: Date = Date()
	dynamic var updatedAt: Date?

}
