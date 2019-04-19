//
//  CarouselCollectionCell.swift
//  SwiftAnimation
//
//  Created by Nitin A on 18/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class CarouselCollectionCell: UICollectionViewCell {
    
    
    // MARK: - Variables
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let backgroundShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(white: 0.99, alpha: 0.8)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 0.6))
        label.numberOfLines = 0
        return label
    }()
    
    var exercise: FitnessExercise? {
        didSet {
            backgroundImageView.image = exercise?.backgroundImage
            titleLabel.text = exercise?.title.uppercased()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(backgroundImageView)
        addSubview(backgroundShadowView)
        addSubview(titleLabel)
        
        backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundShadowView.leftAnchor.constraint(equalTo: backgroundImageView.leftAnchor).isActive = true
        backgroundShadowView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor).isActive = true
        backgroundShadowView.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor).isActive = true
        backgroundShadowView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
