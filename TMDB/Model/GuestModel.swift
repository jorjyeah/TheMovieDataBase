//
//  GuestModel.swift
//  TMDB
//
//  Created by George Joseph Kristian on 26/05/22.
//

import Foundation

struct GuestModel: Codable {
    let success: Bool
    let guestSessionID, expiresAt: String

    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }
}
