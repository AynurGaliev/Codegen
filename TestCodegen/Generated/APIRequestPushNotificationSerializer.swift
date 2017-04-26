//
// APIRequestPushNotificationSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestPushNotificationSerializer: class {
	func serialize(enAPIRequestPushNotification: ENAPIRequestPushNotification?, depth: Int) -> APIRequestPushNotification?
	func serialize(enAPIRequestPushNotifications: [ENAPIRequestPushNotification], depth: Int) -> [APIRequestPushNotification]
	var cMessageTextSerializer: ICMessageTextSerializer! { get set }
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestPushNotificationSerializer: IAPIRequestPushNotificationSerializer {

	//MARK: - Dependencies
	var cMessageTextSerializer: ICMessageTextSerializer!
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequestPushNotification: ENAPIRequestPushNotification?, depth: Int) -> APIRequestPushNotification? {

		guard let lAPIRequestPushNotification = enAPIRequestPushNotification else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let isRequired = lAPIRequestPushNotification.isRequired

		//MARK: - Serializing relationships
		let message = self.cMessageTextSerializer.serialize(enCMessageText: lAPIRequestPushNotification.message, depth: maxDepth - 1)!
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequestPushNotification.queue, depth: maxDepth - 1)

		return APIRequestPushNotification(isRequired: isRequired, message: message, queue: queue)
	}

	func serialize(enAPIRequestPushNotifications: [ENAPIRequestPushNotification], depth: Int) -> [APIRequestPushNotification] {

		guard enAPIRequestPushNotifications.count != 0 else { return [] }
		var serializedAPIRequestPushNotifications: [APIRequestPushNotification] = []
		for value in enAPIRequestPushNotifications {
			guard let entity = self.serialize(enAPIRequestPushNotification: value, depth: depth) else { continue }
			serializedAPIRequestPushNotifications.append(entity)
		}
		return serializedAPIRequestPushNotifications
	}
}
