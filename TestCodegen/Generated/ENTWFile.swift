//
// ENTWFile.swift
// TestCodegen
//
// Created by Codegen on 24/04/2017 14:33.
// Copyright © 2017 Codegen. All rights reserved.
//

import Foundation

import RealmSwift

final class ENTWFile: ENTWObject {

	//MARK: - Attributes
	dynamic var data: Data = Data()
	dynamic var deviceCreatedAt: Date = Date()
	dynamic var id: String = ""
	dynamic var type: String = ""

	//MARK: - One-to-one relationships
	dynamic var userCase: ENTWCase?

}
