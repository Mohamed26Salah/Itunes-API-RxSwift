//
//  ItunesParser.swift
//  Itunes-API-RxSwift
//
//  Created by Mohamed Salah on 14/08/2023.
//


import Foundation
import OptionallyDecodable

// MARK: - DecodeScene
struct ItunesParser: Codable {
    var resultCount: Int
    var results: [ItunesSearchResult]

    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}

// MARK: - Result
struct ItunesSearchResult: Codable {
    var wrapperType: WrapperType?
    var kind: Kind?
    var collectionID: Int?
    var trackID: Int?
    var artistName: String
    var collectionName: String?
    var trackName: String?
    var collectionCensoredName: String?
    var trackCensoredName: String?
    var collectionArtistID: Int?
    var collectionArtistViewURL: String?
    var collectionViewURL: String?
    var trackViewURL: String?
    var previewURL: String
    var artworkUrl30: String?
    var artworkUrl60: String
    var artworkUrl100: String
    var collectionPrice: Double
    var trackPrice: Double?
    var trackRentalPrice: Double?
    var collectionHDPrice: Double?
    var trackHDPrice: Double?
    var trackHDRentalPrice: Double?
    var releaseDate: String
    var collectionExplicitness: Explicitness?
    var trackExplicitness: Explicitness?
    var discCount: Int?
    var discNumber: Int?
    var trackCount: Int?
    var trackNumber: Int?
    var trackTimeMillis: Int?
    var country: Country?
    var currency: Currency?
    var primaryGenreName: String
    var contentAdvisoryRating: String?
    var longDescription: String?
    var hasITunesExtras: Bool?
    var shortDescription: String?
    var artistID: Int?
    var artistViewURL: String?
    var isStreamable: Bool?
    var copyright: String?
    var description: String?
    var collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType = "wrapperType"
        case kind = "kind"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case collectionCensoredName = "collectionCensoredName"
        case trackCensoredName = "trackCensoredName"
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case trackRentalPrice = "trackRentalPrice"
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case trackCount = "trackCount"
        case trackNumber = "trackNumber"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case longDescription = "longDescription"
        case hasITunesExtras = "hasITunesExtras"
        case shortDescription = "shortDescription"
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
        case isStreamable = "isStreamable"
        case copyright = "copyright"
        case description = "description"
        case collectionArtistName = "collectionArtistName"
    }
}

enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case featureMovie = "feature-movie"
    case song = "song"
    case tvEpisode = "tv-episode"
}

enum WrapperType: String, Codable {
    case audiobook = "audiobook"
    case track = "track"
}

