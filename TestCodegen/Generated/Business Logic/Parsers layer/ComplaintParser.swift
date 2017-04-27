//
// ComplaintParser.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IComplaintParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENComplaint
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENComplaint]
	var caseParser: ICaseParser! { get set }
	var tagParser: ITagParser! { get set }
}

final class ComplaintParser: IComplaintParser {

	//MARK: - Dependencies
	var caseParser: ICaseParser!
	var tagParser: ITagParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENComplaint {

		let enComplaint: ENComplaint = ENComplaint()

		//MARK: - Parsing attributes
		enComplaint.archived = try json.value(by: "archived")
		enComplaint.complaintSet = try json.value(by: "complaintSet")
		enComplaint.id = try json.value(by: "id")
		enComplaint.name = try json.value(by: "name")
		enComplaint.order.value = try json.value(by: "order")
		enComplaint.priority = try json.value(by: "priority")
		enComplaint.showInterventions = try json.value(by: "showInterventions")
		enComplaint.showOnsets = try json.value(by: "showOnsets")
		enComplaint.showSymptoms = try json.value(by: "showSymptoms")
		enComplaint.showVitals = try json.value(by: "showVitals")

		//MARK: - One-to-many relationships parsing
		let _cases = try self.caseParser.serialize(jsonArray: json.value(by: "cases"))
		_cases.forEach { enComplaint.cases.append($0) }

		//MARK: - Many-to-many relationships parsing
		let _tags = try self.tagParser.serialize(jsonArray: json.value(by: "tags"))
		_tags.forEach { $0.complaints.append(enComplaint) }

		return enComplaint
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENComplaint] {
		guard jsonArray.count > 0 else { return [] }
		var enComplaints: [ENComplaint] = []
		for json in jsonArray {
			let enComplaint: ENComplaint = try self.serialize(json: json)
			enComplaints.append(enComplaint)
		}
		return enComplaints
	}

}
