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
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let backgroundShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        view.layer.cornerRadius = 15.0
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.99, alpha: 0.8)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 0.6))
        label.numberOfLines = 0
        return label
    }()
    
    var exercise: FitnessExercise! {
        didSet {
            backgroundImageView.image = UIImage(named: exercise.imageName)
            titleLabel.text = exercise.title.uppercased()
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
        
        addSubviews(backgroundImageView, backgroundShadowView, titleLabel)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backgroundShadowView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-25)
            make.centerY.equalToSuperview()
        }
    }
}
