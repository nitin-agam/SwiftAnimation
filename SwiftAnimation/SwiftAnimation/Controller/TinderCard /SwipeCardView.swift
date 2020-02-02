//
//  SwipeCardView.swift
//  SwiftAnimation
//
//  Created by Nitin A on 01/02/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit
import NAExtensions
import SnapKit

protocol SwipeCardViewProtocol {
    func didUserInfoTapped(user: TinderUser)
}

class SwipeCardView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    lazy private var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "info_icon"), for: .normal)
        button.addTarget(self, action: #selector(handleInfo), for: .touchUpInside)
        return button
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    let likeView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 0.101, green: 0.737, blue: 0.611, alpha: 1).cgColor
        view.transform = CGAffineTransform(rotationAngle: -.pi / 8)
        view.backgroundColor = .white
        return view
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.addCharacterSpacing()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "LIKE", attributes:[.font : UIFont.boldSystemFont(ofSize: 28)])
        label.textColor = UIColor(red: 0.101, green: 0.737, blue: 0.611, alpha: 1)
        return label
    }()
    
    let nopeView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 0.9, green: 0.29, blue: 0.23, alpha: 1).cgColor
        view.transform = CGAffineTransform(rotationAngle: .pi / 8)
        view.backgroundColor = .white
        return view
    }()
    
    let nopeLabel: UILabel = {
        let label = UILabel()
        label.addCharacterSpacing()
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "NOPE", attributes:[.font : UIFont.boldSystemFont(ofSize: 28)])
        label.textColor = UIColor(red: 0.9, green: 0.29, blue: 0.23, alpha: 1)
        return label
    }()
    
    var user: TinderUser! {
        didSet {
            profileImageView.image = UIImage(named: self.user.imageName)
            countryLabel.text = self.user.country
            let attributedText = NSMutableAttributedString(string: self.user.name, attributes: [.font: UIFont.boldSystemFont(ofSize: 35), .foregroundColor: UIColor.white])
            attributedText.append(NSAttributedString(string: "  " + String(self.user.age), attributes: [.font: UIFont.boldSystemFont(ofSize: 20), .foregroundColor: UIColor.white]))
            nameLabel.attributedText = attributedText
        }
    }
    
    var delegate: SwipeCardViewProtocol?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        addSubviews(profileImageView, infoButton, countryLabel, nameLabel, likeView, nopeView)
        profileImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-20)
            make.height.width.equalTo(35)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(infoButton.snp.centerY)
            make.height.equalTo(25)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(countryLabel.snp.left)
            make.bottom.equalTo(countryLabel.snp.top).offset(-5)
        }
        
        likeView.addSubview(likeLabel)
        likeView.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.width.equalTo(85)
            make.left.top.equalTo(20)
        }
        likeLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        nopeView.addSubview(nopeLabel)
        nopeView.snp.makeConstraints { (make) in
            make.height.equalTo(likeView.snp.height)
            make.width.equalTo(likeView.snp.width)
            make.right.equalTo(-20)
            make.top.equalTo(likeView.snp.top)
        }
        nopeLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let gradientFrame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        profileImageView.addBlackGradient(frame: gradientFrame, colors: [.clear, .black])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleInfo() {
        if let delegate = self.delegate {
            delegate.didUserInfoTapped(user: self.user)
        }
    }
}
