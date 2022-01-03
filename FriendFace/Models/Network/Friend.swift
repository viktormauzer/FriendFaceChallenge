//
//  Friend.swift
//  FriendFace
//
//  Created by Viktor Mauzer on 03.01.2022..
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
