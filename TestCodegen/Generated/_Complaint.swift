//
// _Complaint.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _Complaint: _Object {

	let archived: Bool
	let complaintSet: String?
	let id: String
	let name: String
	let order: Int?
	let priority: Int
	let showInterventions: Bool
	let showOnsets: Bool
	let showSymptoms: Bool
	let showVitals: Bool
	let cases: [Case]?
	let tags: [Tag]?

	init(archived: Bool, cases: [Case]?, complaintSet: String?, createdAt: Date, id: String, localUpdatedAt: Date, name: String, order: Int?, priority: Int, showInterventions: Bool, showOnsets: Bool, showSymptoms: Bool, showVitals: Bool, tags: [Tag]?, updatedAt: Date?) {
		self.archived = archived
		self.cases = cases
		self.complaintSet = complaintSet
		self.id = id
		self.name = name
		self.order = order
		self.priority = priority
		self.showInterventions = showInterventions
		self.showOnsets = showOnsets
		self.showSymptoms = showSymptoms
		self.showVitals = showVitals
		self.tags = tags
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let archived: String = "archived"
		static let complaintSet: String = "complaintSet"
		static let id: String = "id"
		static let name: String = "name"
		static let order: String = "order"
		static let priority: String = "priority"
		static let showInterventions: String = "showInterventions"
		static let showOnsets: String = "showOnsets"
		static let showSymptoms: String = "showSymptoms"
		static let showVitals: String = "showVitals"
		static let cases: String = "cases"
		static let tags: String = "tags"
	}
}

func ==(lhs: Complaint, rhs: Complaint) -> Bool {
	return lhs.archived == rhs.archived && lhs.complaintSet == rhs.complaintSet && lhs.id == rhs.id && lhs.name == rhs.name && lhs.order == rhs.order && lhs.priority == rhs.priority && lhs.showInterventions == rhs.showInterventions && lhs.showOnsets == rhs.showOnsets && lhs.showSymptoms == rhs.showSymptoms && lhs.showVitals == rhs.showVitals && lhs.cases == rhs.cases && lhs.tags == rhs.tags 
}

func ==(lhs: Complaint?, rhs: Complaint?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [Complaint]?, rhs: [Complaint]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
