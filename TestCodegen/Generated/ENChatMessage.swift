//
// ENChatMessage.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
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

	//MARK: - Relationships
	dynamic var createdBy: ENUser?
	dynamic var userCase: ENCase?

}
