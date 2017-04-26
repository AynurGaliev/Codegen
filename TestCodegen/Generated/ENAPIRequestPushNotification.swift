//
// ENAPIRequestPushNotification.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENAPIRequestPushNotification: ENAPIRequest {


	//MARK: - One-to-one relationships
	private let messages = LinkingObjects(fromType: ENCMessageText.self, property: "pushNotifications")
	var message: ENCMessageText? {
		return self.messages.first
	}

}
