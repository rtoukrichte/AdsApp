//
//  CategoriesModel.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import Foundation


// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
}

typealias Categories = [Category]
