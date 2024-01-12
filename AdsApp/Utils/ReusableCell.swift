//
//  ReusableCell.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 10/01/2024.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String.init(describing: self)
    }
}

protocol ConfigurableCell: ReusableCell {
    associatedtype T
    func configureCell(with item: T, someValue: String)
}
