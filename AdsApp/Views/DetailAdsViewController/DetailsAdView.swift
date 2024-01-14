//
//  DetailsAdView.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 11/01/2024.
//

import UIKit

class DetailsAdView: UIView {
    
    var detailsAdViewModel: DetailsAdViewModel? {
        didSet {
            setDetailsData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_not_found")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iMac 27 pouces mi 2011 Paris"
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-medium", size: 16)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "350 €"
        label.font = UIFont(name: "HelveticaNeue-bold", size: 18)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.font = UIFont(name: "HelveticaNeue-light", size: 16)
        label.textColor = .gray
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Publiée le 11/01/2024 à 12h00"
        label.font = UIFont(name: "HelveticaNeue-light", size: 14)
        label.textColor = .black
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Lorem ipsum description loreem sum ipsum lorem loreem sum ipsum lorem loreem sum ipsum"
        textView.font = UIFont(name: "HelveticaNeue-medium", size: 16)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 15)
        textView.backgroundColor = .clear
        textView.textColor = UIColor.lightGray
        textView.sizeToFit()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let urgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Urgent"
        label.font = UIFont(name: "HelveticaNeue-bold", size: 14)
        label.textColor = .white
        return label
    }()
    
    let urgentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.masksToBounds = true
        view.isHidden = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont(name: "HelveticaNeue-medium", size: 15)
        label.textColor = .black
        return label
    }()
    
    private func setupViews() {
        addSubview(thumbImageView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(separatorView)
        addSubview(descriptionTextView)
        addSubview(descriptionLabel)
        
        urgentView.addSubview(urgentLabel)
        addSubview(urgentView)
        
        
        addConstraintsWithFormat("H:|-0-[v0]-0-|", views: thumbImageView)
        addConstraintsWithFormat("H:|-0-[v0]-0-|", views: urgentView)
        addConstraintsWithFormat("H:|-15-[v0]-15-|", views: separatorView)
        
        addConstraint(NSLayoutConstraint(item: thumbImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 300))
        
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbImageView, attribute: .bottom, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -15))
        
        
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .top, relatedBy: .equal, toItem: categoryLabel, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: priceLabel, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .top, relatedBy: .equal, toItem: priceLabel, attribute: .bottom, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: self.frame.width-80))
        
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 60))
        
        addConstraint(NSLayoutConstraint(item: urgentLabel, attribute: .centerX, relatedBy: .equal, toItem: urgentView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: urgentLabel, attribute: .centerY, relatedBy: .equal, toItem: urgentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: separatorView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1.2))
        
        
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: separatorView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        
        
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 15))
        
    }
    
    func setDetailsData() {
        guard let detailsAd = detailsAdViewModel else {
            return
        }
        
        self.titleLabel.text = detailsAd.adTitle
        self.priceLabel.text = detailsAd.formattedPrice
        self.categoryLabel.text = detailsAd.categoryName
        self.descriptionTextView.text = detailsAd.adDescription
        self.dateLabel.text = String(format: "Publiée le %@", detailsAdViewModel?.getFormattedDate() ?? "")
        
        self.urgentView.isHidden = !detailsAd.isUrgent
        
        guard let thumbURL = detailsAd.thumbImageURL else {
            return
        }
        
        self.thumbImageView.load(url: thumbURL) { isLoded in
            if !isLoded {
                DispatchQueue.main.async {
                    self.thumbImageView.image = UIImage(named: "image_not_found")
                }
            }
        }
    }
    
}
