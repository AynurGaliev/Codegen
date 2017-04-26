//
// APIRequestChatSerializer.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 18:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol IAPIRequestChatSerializer: class {
	func serialize(enAPIRequestChat: ENAPIRequestChat?, depth: Int) -> APIRequestChat?
	func serialize(enAPIRequestChats: [ENAPIRequestChat], depth: Int) -> [APIRequestChat]
	var caseQueueSerializer: ICaseQueueSerializer! { get set }
}

final class APIRequestChatSerializer: IAPIRequestChatSerializer {

	//MARK: - Dependencies
	var caseQueueSerializer: ICaseQueueSerializer!

	func serialize(enAPIRequestChat: ENAPIRequestChat?, depth: Int) -> APIRequestChat? {

		guard let lAPIRequestChat = enAPIRequestChat else { return nil }
		guard depth > 0 else { return nil }
		let maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)

		//MARK: - Serializing attributes
		let isRequired = lAPIRequestChat.isRequired
		let parameters = lAPIRequestChat.parameters

		//MARK: - Serializing relationships
		let queue = self.caseQueueSerializer.serialize(enCaseQueue: lAPIRequestChat.queue, depth: maxDepth - 1)

		return APIRequestChat(isRequired: isRequired, parameters: parameters, queue: queue)
	}

	func serialize(enAPIRequestChats: [ENAPIRequestChat], depth: Int) -> [APIRequestChat] {

		guard enAPIRequestChats.count != 0 else { return [] }
		var serializedAPIRequestChats: [APIRequestChat] = []
		for value in enAPIRequestChats {
			guard let entity = self.serialize(enAPIRequestChat: value, depth: depth) else { continue }
			serializedAPIRequestChats.append(entity)
		}
		return serializedAPIRequestChats
	}
}
