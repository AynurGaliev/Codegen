//
// _CMessageText.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _CMessageText: _ChatMessage {

	let content: String

	init(content: String, createdAt: Date, createdBy: User, id: String, isRead: Bool, localUpdatedAt: Date, senderOrganization: String?, source: String, type: String, updatedAt: Date?, userCase: Case) {
		self.content = content
		super.init(createdAt: createdAt, createdBy: createdBy, id: id, isRead: isRead, localUpdatedAt: localUpdatedAt, senderOrganization: senderOrganization, source: source, type: type, updatedAt: updatedAt, userCase: userCase)
	}

	enum Keys {
		static let content: String = "content"
	}
}

func ==(lhs: CMessageText, rhs: CMessageText) -> Bool {
	return lhs.content == rhs.content 
}

func ==(lhs: CMessageText?, rhs: CMessageText?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [CMessageText]?, rhs: [CMessageText]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
