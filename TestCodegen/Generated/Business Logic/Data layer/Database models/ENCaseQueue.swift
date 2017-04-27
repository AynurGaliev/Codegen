//
// ENCaseQueue.swift
// TestCodegen
//
// Created by Codegen on 27/04/2017 17:29.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENCaseQueue: RealmSwift.Object {


	//MARK: - One-to-one relationships
	dynamic var queueCase: ENCase?

	//MARK: - One-to-many relationships
	let requests = List<ENAPIRequest>()

}
