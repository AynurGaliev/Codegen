//
// ENTWCMessageText.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWCMessageText: ENTWChatMessage {

	//MARK: - Attributes
	dynamic var content: String = ""

	//MARK: - One-to-many relationships
	let pushNotifications = List<ENTWAPIRequestPushNotification>()

}
