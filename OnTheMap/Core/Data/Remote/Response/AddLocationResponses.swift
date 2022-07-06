//
//  AddLocationResponses.swift
//  OnTheMap
//
//  Created by Gilang Ramadhan on 06/07/22.
//

import Foundation

// MARK: - Welcome
struct AddLocationResponses: Codable {
    let objectID, createdAt: String

    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case createdAt
    }
}
