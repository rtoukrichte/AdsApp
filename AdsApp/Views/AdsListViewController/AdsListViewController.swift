//
//  AdsListViewController.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import UIKit
import Combine

class AdsListViewController: UIViewController {

    var activityLoader: UIActivityIndicatorView?
    var collectionView: UICollectionView?
    let tableView = UITableView()
    
    var safeArea: UILayoutGuide!
    
    let adsListViewModel = AdsListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    var filtredAds = Ads()
    var isFirstLaunch = true
    var selectedFilterIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "Liste des announces"
        safeArea = view.layoutMarginsGuide
        
        showActivityLoader()
        
        setupCollectionView()
        setupTableView()
        setupBinding()
    }
    
    private func setupCollectionView() {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60), collectionViewLayout: layout)
        
        collectionView?.backgroundColor = .systemGray6
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isHidden = true
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        
        view.addSubview(collectionView ?? UICollectionView())
    }

    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: collectionView!.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = true
        
        tableView.register(AdsListCell.self, forCellReuseIdentifier: AdsListCell.reuseIdentifier)
    }
    
    private func setupBinding() {
        adsListViewModel.$allAds.sink { [weak self] _ in
            self?.updateAdsData()
        }.store(in: &cancellables)
        
        adsListViewModel.$allCategories.sink { [weak self] _ in
            self?.updateCategoryData()
        }.store(in: &cancellables)
        
        adsListViewModel.$errorType.sink { error in
            guard let error = error else { return }
            debugPrint(error.localizedDescription)
        }.store(in: &cancellables)
    }
    
    private func updateAdsData() {
        DispatchQueue.main.async {
            self.filtredAds = self.adsListViewModel.allAds
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.hideActivityLoader()
        }
    }
    
    private func updateCategoryData() {
        DispatchQueue.main.async {
            self.collectionView?.isHidden = false
            self.collectionView?.reloadData()
        }
    }
    
    func showActivityLoader() {
        activityLoader = UIActivityIndicatorView(style: .large)
        activityLoader?.center = self.view.center
        view.addSubview(activityLoader!)
        activityLoader?.startAnimating()
    }

    func hideActivityLoader() {
        if (activityLoader != nil) {
            activityLoader?.stopAnimating()
        }
    }
}

extension AdsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsListViewModel.allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
        
        if (indexPath.row == 0 && isFirstLaunch) {
            self.isFirstLaunch = false
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }
        
        let currentCategory = adsListViewModel.allCategories[indexPath.row]
        cell.configureCell(with: currentCategory, someValue: "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = adsListViewModel.allCategories[indexPath.row]
        if self.selectedFilterIndex != indexPath.row {
            self.selectedFilterIndex = indexPath.row
            
            let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
            cell.isSelected = true
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

            if indexPath.row == 0 {
                self.updateAdsData()
            }
            else{
                self.filtredAds = adsListViewModel.returnedFiltredAds(by: selectedItem)
                self.tableView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel()
        label.text = adsListViewModel.allCategories[indexPath.row].name

        var rectLabel: CGRect = label.frame
        rectLabel.size = (label.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-medium", size: 14)!]))!
        let labelWith = rectLabel.width + 20
        
        return CGSize(width: labelWith, height: 30)
    }
}

extension AdsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtredAds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentAd = self.filtredAds[indexPath.row]
        let categoryName = adsListViewModel.getCategoryName(from: currentAd.categoryID)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AdsListCell.reuseIdentifier, for: indexPath) as? AdsListCell
        cell?.selectionStyle = .none
        cell?.configureCell(with: currentAd, someValue: categoryName)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAd = self.filtredAds[indexPath.row]
        
        let detailsAdViewModel = DetailsAdViewModel(ad: selectedAd, adsViewModel: adsListViewModel)
        let detailsVC = DetailAdViewController(detailsViewModel: detailsAdViewModel)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
}

