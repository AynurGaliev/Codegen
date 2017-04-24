//
// ENTWComplaint.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWComplaint: ENTWObject {

	//MARK: - Attributes
	dynamic var archived: Bool = false
	dynamic var complaintSet: String?
	dynamic var id: String = ""
	dynamic var name: String = ""
	let order = RealmOptional<Int>()
	dynamic var priority: Int = 0
	dynamic var showInterventions: Bool = false
	dynamic var showOnsets: Bool = false
	dynamic var showSymptoms: Bool = false
	dynamic var showVitals: Bool = false

	//MARK: - One-to-one relationships
	dynamic var cases: ENTWCase?

	//MARK: - One-to-many relationships
	let tags = List<ENTWTag>()

}
