//
// APIRequestPushNotificationParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestPushNotificationParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestPushNotification
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestPushNotification]
	var cMessageTextParser: ICMessageTextParser! { get set }
}

final class APIRequestPushNotificationParser: IAPIRequestPushNotificationParser {

	//MARK: - Dependencies
	var cMessageTextParser: ICMessageTextParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestPushNotification {

		let enAPIRequestPushNotification: ENAPIRequestPushNotification = ENAPIRequestPushNotification()

		//MARK: - One-to-one relationships parsing
		enAPIRequestPushNotification.message = try self.cMessageTextParser.serialize(json: json.value(by: "message"))

		return enAPIRequestPushNotification
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestPushNotification] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequestPushNotifications: [ENAPIRequestPushNotification] = []
		for json in jsonArray {
			let enAPIRequestPushNotification: ENAPIRequestPushNotification = try self.serialize(json: json)
			enAPIRequestPushNotifications.append(enAPIRequestPushNotification)
		}
		return enAPIRequestPushNotifications
	}

}
