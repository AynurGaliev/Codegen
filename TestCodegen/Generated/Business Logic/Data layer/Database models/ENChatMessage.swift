//
// ENChatMessage.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

class ENChatMessage: ENObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var isRead: Bool = false
	dynamic var senderOrganization: String?
	dynamic var source: String = ""
	dynamic var type: String = ""

	//MARK: - One-to-one relationships
	private let createdBys = LinkingObjects(fromType: ENUser.self, property: "messages")
	var createdBy: ENUser? {
		return self.createdBys.first
	}
	dynamic var userCase: ENCase?

}
