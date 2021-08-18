//
//  ReviewListResponse.swift
//  GBStore
//
//  Created by Дима Давыдов on 02.07.2021.
//

import Foundation

struct ReviewListItem: Codable {
    let id_comment: Int
    let id_user: Int
    let text: String
}

typealias ReviewListResponse = [ReviewListItem]
