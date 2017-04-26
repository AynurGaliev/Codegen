//
// ENTag.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTag: ENObject {

	//MARK: - Attributes
	dynamic var groupIdentifier: String = ""
	dynamic var id: String = ""
	dynamic var isSelected: Bool = false
	dynamic var name: String = ""
	dynamic var typeIdentifier: String = ""

	//MARK: - One-to-many relationships
	let cases =  LinkingObjects(fromType: ENCase.self, property: "selectedTags")
	let complaints =  LinkingObjects(fromType: ENComplaint.self, property: "tags")

}
