//
// ENCMessageText.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENCMessageText: ENChatMessage {

	//MARK: - Attributes
	dynamic var content: String = ""

	//MARK: - One-to-many relationships
	let pushNotifications = LinkingObjects(fromType: ENAPIRequestPushNotification.self, property: "message")

}
