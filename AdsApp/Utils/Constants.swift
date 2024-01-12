//
//  Constants.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import Foundation

struct Constants {
    
    //https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json
    static let domaineName = "https://raw.githubusercontent.com/"
    static let path = "leboncoin/paperclip/master/"
    
    static let baseURL = domaineName + path
    
    static let adsURL = baseURL + "listing.json"
    static let categoriesURL = baseURL + "categories.json"
        
}

