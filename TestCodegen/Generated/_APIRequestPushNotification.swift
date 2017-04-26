//
// _APIRequestPushNotification.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _APIRequestPushNotification: _APIRequest {

	let message: CMessageText

	init(isRequired: Bool, message: CMessageText, queue: CaseQueue?) {
		self.message = message
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let message: String = "message"
	}
}

func ==(lhs: APIRequestPushNotification, rhs: APIRequestPushNotification) -> Bool {
	return lhs.message == rhs.message 
}

func ==(lhs: APIRequestPushNotification?, rhs: APIRequestPushNotification?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [APIRequestPushNotification]?, rhs: [APIRequestPushNotification]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
