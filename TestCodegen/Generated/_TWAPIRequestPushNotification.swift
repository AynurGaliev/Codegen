//
// _TWAPIRequestPushNotification.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

class _TWAPIRequestPushNotification: _TWAPIRequest {

	let message: TWCMessageText

	init(isRequired: Bool, message: TWCMessageText, queue: TWCaseQueue?) {
		self.message = message
		super.init(isRequired: isRequired, queue: queue)
	}

	enum Keys {
		static let message: String = "message"
	}
}

func ==(lhs: TWAPIRequestPushNotification, rhs: TWAPIRequestPushNotification) -> Bool {
	return lhs.message == rhs.message 
}

func ==(lhs: TWAPIRequestPushNotification?, rhs: TWAPIRequestPushNotification?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}

func ==(lhs: [TWAPIRequestPushNotification]?, rhs: [TWAPIRequestPushNotification]?) -> Bool {
	guard lhs != nil || rhs != nil else { return true }
	if (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }
	return lhs! == rhs!
}
