//
//  CategoryCell.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 11/01/2024.
//

import UIKit

class CategoryCell: UICollectionViewCell, ConfigurableCell {
    
    typealias T = Category
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.7
        view.layer.borderColor = UIColor.orange.cgColor
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loisirs"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-medium", size: 14)
        return label
    }()
    
    func configureCell(with item: Category, someValue: String) {
        self.titleLabel.text = item.name
    }
    
    private func setupViews() {
        containerView.addSubview(titleLabel)
        addSubview(containerView)
        
        addConstraintsWithFormat("H:|-0-[v0]-0-|", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    func didSelectCell() {
        
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.containerView.backgroundColor = .orange
                self.titleLabel.textColor = .white
            }
            else {
                self.containerView.backgroundColor = .clear
                self.titleLabel.textColor = .black
            }
        }
    }

}
