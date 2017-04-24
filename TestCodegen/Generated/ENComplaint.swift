//
// ENComplaint.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENComplaint: ENObject {

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

	//MARK: - Relationships
	dynamic var cases: ENCase?
	let tags = List<ENTag>()

}
