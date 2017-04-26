//
// ENComplaint.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
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

	//MARK: - One-to-many relationships
	let cases = LinkingObjects(fromType: ENCase.self, property: "complaint")
	let tags =  LinkingObjects(fromType: ENTag.self, property: "complaints")

}
