//
// ENUserCredential.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 13:59.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENUserCredential: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var expirationDate: Date = Date()
	dynamic var token: String = ""

	//MARK: - One-to-one relationships
	dynamic var user: ENUser?

}
