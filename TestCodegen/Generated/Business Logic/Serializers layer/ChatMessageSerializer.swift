//
// ChatMessageSerializer.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IChatMessageSerializer: class {
	func serialize(enChatMessage: ENChatMessage?, depth: Int) -> ChatMessage?
	func serialize(enChatMessages: [ENChatMessage], depth: Int) -> [ChatMessage]
	var userSerializer: IUserSerializer! { get set }
	var caseSerializer: ICaseSerializer! { get set }
}

final class ChatMessageSerializer: IChatMessageSerializer {

	//MARK: - Dependencies
	var userSerializer: IUserSerializer!
	var caseSerializer: ICaseSerializer!

	func serialize(enChatMessage: ENChatMessage?, depth: Int) -> ChatMessage? {

		guard let lChatMessage = enChatMessage else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let createdAt = lChatMessage.createdAt
		let id = lChatMessage.id
		let isRead = lChatMessage.isRead
		let localUpdatedAt = lChatMessage.localUpdatedAt
		let senderOrganization = lChatMessage.senderOrganization
		let source = lChatMessage.source
		let type = lChatMessage.type
		let updatedAt = lChatMessage.updatedAt

		//MARK: - Serializing relationships
		let createdBy = self.userSerializer.serialize(enUser: lChatMessage.createdBy, depth: maxDepth - 1)!
		let userCase = self.caseSerializer.serialize(enCase: lChatMessage.userCase, depth: maxDepth - 1)!

		return ChatMessage(createdAt: createdAt, createdBy: createdBy, id: id, isRead: isRead, localUpdatedAt: localUpdatedAt, senderOrganization: senderOrganization, source: source, type: type, updatedAt: updatedAt, userCase: userCase)
	}

	func serialize(enChatMessages: [ENChatMessage], depth: Int) -> [ChatMessage] {

		guard enChatMessages.count != 0 else { return [] }
		var serializedChatMessages: [ChatMessage] = []
		for value in enChatMessages {
			guard let entity = self.serialize(enChatMessage: value, depth: depth) else { continue }
			serializedChatMessages.append(entity)
		}
		return serializedChatMessages
	}
}
