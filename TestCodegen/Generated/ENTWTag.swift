//
// ENTWTag.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWTag: ENTWObject {

	//MARK: - Attributes
	dynamic var groupIdentifier: String = ""
	dynamic var id: String = ""
	dynamic var isSelected: Bool = false
	dynamic var name: String = ""
	dynamic var typeIdentifier: String = ""

	//MARK: - One-to-many relationships
	let cases = List<ENTWCase>()
	let complaints = List<ENTWComplaint>()

}
