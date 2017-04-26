//
// ENFile.swift
// TestCodegen
//
// Created by Codegen on 26/04/2017 12:28.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENFile: ENObject {

	//MARK: - Attributes
	dynamic var data: Data = Data()
	dynamic var deviceCreatedAt: Date = Date()
	dynamic var id: String = ""
	dynamic var type: String = ""

	//MARK: - One-to-one relationships
	dynamic var userCase: ENCase?

}
