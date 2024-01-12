//
//  DetailAdViewModel.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 12/01/2024.
//

import Foundation

class DetailsAdViewModel {
    var ad: Ad
    
    var thumbImageURL: URL?
    var adTitle: String
    var adDescription: String
    var categoryName: String
    var formattedPrice: String
    var adCreationDate: Date
    var isUrgent: Bool
    var adId: Int
    
    init(ad: Ad, adsViewModel: AdsListViewModel) {
        self.ad = ad
        
        self.adId = ad.id
        self.adTitle = ad.title
        self.adDescription = ad.description
        self.isUrgent = ad.isUrgent
        self.formattedPrice = String(format: "%ld €", ad.price)
        self.adCreationDate = ad.creationDate.convertToDate()
        self.categoryName = adsViewModel.getCategoryName(from: ad.categoryID)
        self.thumbImageURL = createThumbURL(ad.imagesURL.thumb ?? "")
    }
    
    private func createThumbURL(_ thumbImage: String) -> URL? {
        return URL(string: thumbImage)
    }
    
    func getFormattedDate() -> String {
        let customFormat = "dd/MM/yyyy 'à' HH:mm"
        let thisDate = self.adCreationDate.createformattedDate(with: customFormat)
        return thisDate ?? ""
    }
    
}
