//
//  AdsModel.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import Foundation

// MARK: - Ad
struct Ad: Codable {
    let id: Int
    let categoryID: Int
    let title: String
    let description: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool
    let siret: String?
    
    var categoryName: String?
    var creationAsDate: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, description, price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
    
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small, thumb: String?
}

typealias Ads = [Ad]
