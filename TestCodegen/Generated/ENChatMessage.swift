//
// ENChatMessage.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
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
	dynamic var createdBy: ENUser?
	dynamic var userCase: ENCase?

}
