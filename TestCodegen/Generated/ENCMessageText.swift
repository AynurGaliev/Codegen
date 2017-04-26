//
// ENCMessageText.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
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
