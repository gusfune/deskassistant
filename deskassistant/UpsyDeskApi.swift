//
//  UpsyDeskApi.swift
//  deskassistant
//
//  Created by Gus Fune on 31/12/2024.
//

import Foundation

struct DeskHeightResponse: Decodable {
    let id: String
    let value: Double
    let state: String
}
