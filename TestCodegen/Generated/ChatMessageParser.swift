//
// ChatMessageParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IChatMessageParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENChatMessage
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENChatMessage]
	var userParser: IUserParser! { get set }
	var caseParser: ICaseParser! { get set }
}

final class ChatMessageParser: IChatMessageParser {

	//MARK: - Dependencies
	var userParser: IUserParser!
	var caseParser: ICaseParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENChatMessage {

		let enChatMessage: ENChatMessage = ENChatMessage()

		//MARK: - Parsing attributes
		enChatMessage.id = try json.value(by: "id")
		enChatMessage.isRead = try json.value(by: "isRead")
		enChatMessage.senderOrganization = try json.value(by: "senderOrganization")
		enChatMessage.source = try json.value(by: "source")
		enChatMessage.type = try json.value(by: "type")

		//MARK: - One-to-one relationships parsing
		let _createdBy = try self.userParser.serialize(json: json.value(by: "createdBy"))
		_createdBy.messages.append(enChatMessage)
		enChatMessage.userCase = try self.caseParser.serialize(json: json.value(by: "userCase"))

		return enChatMessage
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENChatMessage] {
		guard jsonArray.count > 0 else { return [] }
		var enChatMessages: [ENChatMessage] = []
		for json in jsonArray {
			let enChatMessage: ENChatMessage = try self.serialize(json: json)
			enChatMessages.append(enChatMessage)
		}
		return enChatMessages
	}

}
