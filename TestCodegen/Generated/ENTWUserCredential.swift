//
// ENTWUserCredential.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWUserCredential: RealmSwift.Object {

	//MARK: - Attributes
	dynamic var expirationDate: Date = Date()
	dynamic var token: String = ""

	//MARK: - One-to-one relationships
	dynamic var user: ENTWUser?

}
