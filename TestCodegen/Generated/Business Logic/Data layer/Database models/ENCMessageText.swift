//
// ENCMessageText.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENCMessageText: ENChatMessage {

	//MARK: - Attributes
	dynamic var content: String = ""

	//MARK: - One-to-many relationships
	let pushNotifications = List<ENAPIRequestPushNotification>()

}
