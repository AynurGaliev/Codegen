//
// APIRequestChatParser.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestChatParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestChat
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestChat]
}

final class APIRequestChatParser: IAPIRequestChatParser {

	//MARK: - Dependencies

	func serialize(json: Dictionary<String, Any?>) throws -> ENAPIRequestChat {

		let enAPIRequestChat: ENAPIRequestChat = ENAPIRequestChat()

		//MARK: - Parsing attributes
		enAPIRequestChat.parameters = try json.value(by: "parameters")

		return enAPIRequestChat
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENAPIRequestChat] {
		guard jsonArray.count > 0 else { return [] }
		var enAPIRequestChats: [ENAPIRequestChat] = []
		for json in jsonArray {
			let enAPIRequestChat: ENAPIRequestChat = try self.serialize(json: json)
			enAPIRequestChats.append(enAPIRequestChat)
		}
		return enAPIRequestChats
	}

}
