//
//  AdsListCell.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import UIKit

class AdsListCell: UITableViewCell, ConfigurableCell {

    typealias T = Ad
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iMac 27 pouces mi 2011 Paris"
        label.numberOfLines = 2
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
        view.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        view.layer.masksToBounds = true
        view.isHidden = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    func configureCell(with item: Ad, someValue: String) {
        
        self.urgentView.isHidden = !item.isUrgent
        
        self.titleLabel.text = item.title
        self.priceLabel.text = String(format: "%ld €", item.price)
        self.categoryLabel.text = someValue
        
        guard let thumbURL = URL(string: item.imagesURL.thumb ?? "") else {
            self.thumbImageView.image = UIImage(named: "image_not_found")
            return
        }
        
        self.thumbImageView.load(url: thumbURL) { isLoaded in
            if !isLoaded {
                DispatchQueue.main.async {
                    self.thumbImageView.image = UIImage(named: "image_not_found")
                }
            }
        }
    }
   
    private func setupViews() {
        addSubview(thumbImageView)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        urgentView.addSubview(urgentLabel)
        addSubview(urgentView)
        
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: thumbImageView)
        addConstraintsWithFormat("V:|-20-[v0]-20-|", views: urgentView)
        addConstraintsWithFormat("V:|-10-[v0]-10-[v1(1)]|", views: thumbImageView, separatorView)
        
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: separatorView)

        
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .right, relatedBy: .equal, toItem: thumbImageView, attribute: .right, multiplier: 1, constant: -10))
        
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 25))
        addConstraint(NSLayoutConstraint(item: urgentView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 60))
        
        addConstraint(NSLayoutConstraint(item: urgentLabel, attribute: .centerX, relatedBy: .equal, toItem: urgentView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: urgentLabel, attribute: .centerY, relatedBy: .equal, toItem: urgentView, attribute: .centerY, multiplier: 1, constant: 0))

        
        //Title Label constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbImageView, attribute: .bottom, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbImageView, attribute: .right, multiplier: 1, constant: 0))
        
                
        // thumb image height
        addConstraint(NSLayoutConstraint(item: thumbImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 200))
        
        
        // category label
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        
        // Price Label constraints
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .top, relatedBy: .equal, toItem: categoryLabel, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .right, relatedBy: .equal, toItem: categoryLabel, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
    }

}
