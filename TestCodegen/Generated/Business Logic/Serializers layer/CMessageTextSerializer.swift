//
// CMessageTextSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ICMessageTextSerializer: class {
	func serialize(enCMessageText: ENCMessageText?, depth: Int) -> CMessageText?
	func serialize(enCMessageTexts: [ENCMessageText], depth: Int) -> [CMessageText]
	var userSerializer: IUserSerializer! { get set }
	var aPIRequestPushNotificationSerializer: IAPIRequestPushNotificationSerializer! { get set }
	var caseSerializer: ICaseSerializer! { get set }
}

final class CMessageTextSerializer: ICMessageTextSerializer {

	//MARK: - Dependencies
	var userSerializer: IUserSerializer!
	var aPIRequestPushNotificationSerializer: IAPIRequestPushNotificationSerializer!
	var caseSerializer: ICaseSerializer!

	func serialize(enCMessageText: ENCMessageText?, depth: Int) -> CMessageText? {

		guard let lCMessageText = enCMessageText else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let content = lCMessageText.content
		let createdAt = lCMessageText.createdAt
		let id = lCMessageText.id
		let isRead = lCMessageText.isRead
		let localUpdatedAt = lCMessageText.localUpdatedAt
		let senderOrganization = lCMessageText.senderOrganization
		let source = lCMessageText.source
		let type = lCMessageText.type
		let updatedAt = lCMessageText.updatedAt

		//MARK: - Serializing relationships
		let createdBy = self.userSerializer.serialize(enUser: lCMessageText.createdBy, depth: maxDepth - 1)!
		let pushNotifications = self.aPIRequestPushNotificationSerializer.serialize(enAPIRequestPushNotifications: Array(lCMessageText.pushNotifications), depth: maxDepth - 1)
		let userCase = self.caseSerializer.serialize(enCase: lCMessageText.userCase, depth: maxDepth - 1)!

		return CMessageText(content: content, createdAt: createdAt, createdBy: createdBy, id: id, isRead: isRead, localUpdatedAt: localUpdatedAt, pushNotifications: pushNotifications, senderOrganization: senderOrganization, source: source, type: type, updatedAt: updatedAt, userCase: userCase)
	}

	func serialize(enCMessageTexts: [ENCMessageText], depth: Int) -> [CMessageText] {

		guard enCMessageTexts.count != 0 else { return [] }
		var serializedCMessageTexts: [CMessageText] = []
		for value in enCMessageTexts {
			guard let entity = self.serialize(enCMessageText: value, depth: depth) else { continue }
			serializedCMessageTexts.append(entity)
		}
		return serializedCMessageTexts
	}
}
