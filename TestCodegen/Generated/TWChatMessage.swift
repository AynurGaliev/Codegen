//
// TWChatMessage.swift
// TestCodegen
//
// Created by Codegen on 21/04/2017 15:58.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class TWChatMessage: TWObject {

	let id: String
	let isRead: Bool
	let senderOrganization: String?
	let source: String
	let type: String
	let createdBy: TWUser
	let userCase: TWCase

	init(createdAt: Date, createdBy: TWUser, id: String, isRead: Bool, localUpdatedAt: Date, senderOrganization: String?, source: String, type: String, updatedAt: Date?, userCase: TWCase) {
		self.createdBy = createdBy
		self.id = id
		self.isRead = isRead
		self.senderOrganization = senderOrganization
		self.source = source
		self.type = type
		self.userCase = userCase
		super.init(createdAt: createdAt, localUpdatedAt: localUpdatedAt, updatedAt: updatedAt)
	}

	enum Keys {
		static let id: String = "id"
		static let isRead: String = "isRead"
		static let senderOrganization: String = "senderOrganization"
		static let source: String = "source"
		static let type: String = "type"
		static let createdBy: String = "createdBy"
		static let userCase: String = "userCase"
	}
}

func ==(lhs: TWChatMessage, rhs: TWChatMessage) -> Bool {
	return lhs.id == rhs.id && lhs.isRead == rhs.isRead && lhs.senderOrganization == rhs.senderOrganization && lhs.source == rhs.source && lhs.type == rhs.type && lhs.createdBy == rhs.createdBy && lhs.userCase == rhs.userCase 
}

func ==(lhs: TWChatMessage?, rhs: TWChatMessage?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWChatMessage]?, rhs: [TWChatMessage]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
