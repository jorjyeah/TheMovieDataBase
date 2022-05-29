//
//  TrendingModel.swift
//  TMDB
//
//  Created by George Joseph Kristian on 27/05/22.
//

import Foundation

// MARK: - TrendingModel
struct TrendingModel: Codable {
    let page: Int
    let results: [TrendingResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TrendingResult: Codable {
    let video: Bool?
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let voteCount: Int
    let adult: Bool?
    let backdropPath: String
    let id: Int
    let genreIDS: [Int]
    let title: String?
    let originalLanguage: String?
    let originalTitle: String?
    let posterPath: String
    let popularity: Double
    let mediaType: MediaType
    let originalName: String?
    let originCountry: [String]?
    let name, firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case name
        case firstAirDate = "first_air_date"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
