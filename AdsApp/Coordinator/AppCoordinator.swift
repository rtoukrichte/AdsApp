//
//  AppCoordinator.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 01/02/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        print("App coordinator start !")
        goToAds()
    }
    
    
    func goToAds() {
        let mainController = AdsListViewController()
        mainController.coordinator = self
        navigationController.setViewControllers([mainController], animated: true)
    }
    
    func pushDetailAd(for ad: Ad, adsVM: AdsListViewModel) {
        let detailsVM = DetailsAdViewModel(ad: ad, adsViewModel: adsVM)
        let detailsVC = DetailAdViewController(detailsViewModel: detailsVM)
        navigationController.pushViewController(detailsVC, animated: true)
    }
    
}
