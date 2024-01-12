//
//  AdsListViewController.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import UIKit
import Combine

class AdsListViewController: UIViewController {

    let tableView = UITableView()
    var safeArea: UILayoutGuide!
        
    var ads = ["Link", "Zelda", "Ganondorf", "Midna"]
    
    let adsListViewModel = AdsListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        self.title = "Liste des announces"
        safeArea = view.layoutMarginsGuide
        setupTableView()
        
        setupBinding()
    }


    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AdsListCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setupBinding() {
        adsListViewModel.$allAds.sink { [weak self] _ in
            self?.updateData()
        }.store(in: &cancellables)
        
        adsListViewModel.$allCategories.sink { [weak self] _ in
            self?.updateData()
        }.store(in: &cancellables)
        
        adsListViewModel.$errorType.sink { error in
            guard let error = error else { return }
            debugPrint(error.localizedDescription)
        }.store(in: &cancellables)
    }
    
    func updateData() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}

extension AdsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adsListViewModel.allAds.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentAd = adsListViewModel.allAds[indexPath.row]
        let categoryName = adsListViewModel.getCategoryName(from: currentAd.categoryID)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? AdsListCell
        cell?.configureCell(with: currentAd, someValue: categoryName)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
}

