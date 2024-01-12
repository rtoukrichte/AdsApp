//
//  DetailAdViewController.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import UIKit

class DetailAdViewController: UIViewController, UIScrollViewDelegate {

    var detailsView: DetailsAdView?
    
    var detailsViewModel: DetailsAdViewModel?
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(selectedAd: Ad, categoryName: String?, detailsViewModel: DetailsAdViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.detailsViewModel = detailsViewModel
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "\(detailsViewModel?.adId ?? 0)"
        
        setupDetailView()
    }
    
    private func setupDetailView() {
        detailsView = DetailsAdView(frame: self.view.frame)
        detailsView?.detailsAdViewModel = self.detailsViewModel
        setupScrollView()
    }
    
    func setupScrollView() {
        scrollStackViewContainer.addArrangedSubview(detailsView!)
        
        scrollView.addSubview(scrollStackViewContainer)
        
        self.view.addSubview(scrollView)
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        

        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        let sizeThatFitsTextView = detailsView?.descriptionTextView.sizeThatFits(CGSize(width: (detailsView?.descriptionTextView.frame.size.width)!, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView?.height
        
        scrollStackViewContainer.layoutIfNeeded()
        scrollView.layoutIfNeeded()
        scrollView.contentSize.height = scrollView.frame.size.height+(heightOfText ?? 0)
        
    }
    
}

