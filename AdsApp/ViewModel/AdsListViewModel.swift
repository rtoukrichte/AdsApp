//
//  AdsViewModel.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import Foundation
import Combine

class AdsListViewModel: ObservableObject {
    
    private var serviceManager = ServiceManager.shared
    
    private var cancellable = Set<AnyCancellable>()
    
    @Published var allAds = Ads()
    @Published var allCategories = Categories()
    @Published var errorType: NetworkError?
    
    init() {
        self.getCategories()
        self.getAds()
    }
    
    
    func getAds() {
        serviceManager.fetch(from: Constants.adsURL)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorType = error
                    debugPrint("Error from ads == ", error)
                }
            } receiveValue: { [unowned self] in
                let ads: Ads = $0
                                
                var urgentAds = ads.filter { $0.isUrgent }
                var otherAds  = ads.filter { !($0.isUrgent) }
                
                urgentAds.sort {
                    $0.creationDate.convertToDate().compare($1.creationDate.convertToDate()) == ComparisonResult.orderedDescending
                }

                otherAds.sort {
                    $0.creationDate.convertToDate().compare($1.creationDate.convertToDate()) == ComparisonResult.orderedDescending
                }

                self.allAds = Array(urgentAds + otherAds)
            }
            .store(in: &self.cancellable)
    }
    
    
    func getCategories() {
        serviceManager.fetch(from: Constants.categoriesURL)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.errorType = error
                }
            } receiveValue: { [unowned self] in
                var categories: Categories = $0
                categories.sort { $0.name > $1.name }                
                categories.insert(Category(id: 0, name: "Tous"), at: 0)
                
                self.allCategories = categories
            }
            .store(in: &self.cancellable)
    }
    
    func getCategoryName(from id: Int) -> String {
        let categories = self.allCategories.filter { $0.id == id }
        
        guard let returnedCategory = categories.first else {
            return ""
        }
        
        return returnedCategory.name
    }
    
    func returnedFiltredAds(by category: Category) -> Ads {
        if category.id == 0 {
            return self.allAds
        }
        else {
            let filtredAds = self.allAds.filter { $0.categoryID == category.id }
            
            return filtredAds
        }
    }
    
}
