//
// ENTWCaseQueue.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWCaseQueue: RealmSwift.Object {


	//MARK: - One-to-one relationships
	dynamic var queueCase: ENTWCase?

	//MARK: - One-to-many relationships
	let requests = List<ENTWAPIRequest>()

}
