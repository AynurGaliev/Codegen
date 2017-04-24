//
// ENCaseQueue.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENCaseQueue: RealmSwift.Object {


	//MARK: - Relationships
	dynamic var queueCase: ENCase?
	let requests = List<ENAPIRequest>()

}
