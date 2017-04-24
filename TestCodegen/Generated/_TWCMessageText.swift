//
// _TWCMessageText.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWCMessageText: _TWChatMessage {

	let content: String
	let pushNotifications: [TWAPIRequestPushNotification]?

	init(content: String, createdAt: Date, createdBy: TWUser, id: String, isRead: Bool, localUpdatedAt: Date, pushNotifications: [TWAPIRequestPushNotification]?, senderOrganization: String?, source: String, type: String, updatedAt: Date?, userCase: TWCase) {
		self.content = content
		self.pushNotifications = pushNotifications
		super.init(createdAt: createdAt, createdBy: createdBy, id: id, isRead: isRead, localUpdatedAt: localUpdatedAt, senderOrganization: senderOrganization, source: source, type: type, updatedAt: updatedAt, userCase: userCase)
	}

	enum Keys {
		static let content: String = "content"
		static let pushNotifications: String = "pushNotifications"
	}
}

func ==(lhs: TWCMessageText, rhs: TWCMessageText) -> Bool {
	return lhs.content == rhs.content && lhs.pushNotifications == rhs.pushNotifications 
}

func ==(lhs: TWCMessageText?, rhs: TWCMessageText?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWCMessageText]?, rhs: [TWCMessageText]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
