//
// CMessageTextParser.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

protocol ICMessageTextParser: class {
	func serialize(json: Dictionary<String, Any?>) throws -> ENCMessageText
	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENCMessageText]
	var aPIRequestPushNotificationParser: IAPIRequestPushNotificationParser! { get set }
}

final class CMessageTextParser: ICMessageTextParser {

	//MARK: - Dependencies
	var aPIRequestPushNotificationParser: IAPIRequestPushNotificationParser!

	func serialize(json: Dictionary<String, Any?>) throws -> ENCMessageText {

		let enCMessageText: ENCMessageText = ENCMessageText()

		//MARK: - Parsing attributes
		enCMessageText.content = try json.value(by: "content")

		return enCMessageText
	}

	func serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [ENCMessageText] {
		guard jsonArray.count > 0 else { return [] }
		var enCMessageTexts: [ENCMessageText] = []
		for json in jsonArray {
			let enCMessageText: ENCMessageText = try self.serialize(json: json)
			enCMessageTexts.append(enCMessageText)
		}
		return enCMessageTexts
	}

}
