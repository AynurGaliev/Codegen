//
// ENUserCredential.swift
// TestCodegen
//
// Created by Codegen on 23/04/2017 22:54.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENUserCredential: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var expirationDate: Date = Date()
	dynamic var token: String = ""

	//MARK: - Relationships
	dynamic var user: ENUser?

}
