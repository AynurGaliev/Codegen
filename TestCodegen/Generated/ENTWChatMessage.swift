//
// ENTWChatMessage.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

class ENTWChatMessage: ENTWObject {

	//MARK: - Attributes
	dynamic var id: String = ""
	dynamic var isRead: Bool = false
	dynamic var senderOrganization: String?
	dynamic var source: String = ""
	dynamic var type: String = ""

	//MARK: - One-to-one relationships
	dynamic var createdBy: ENTWUser?
	dynamic var userCase: ENTWCase?

}
