//
//  SelectionMenuLauncher.swift
//  SwiftAnimation
//
//  Created by Nitin A on 17/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class SelectionMenuLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let blackView = UIView()
    private let cellIdentifier = "SelectionMenuCollectionCell"
    static private let kCellHeight: CGFloat = 50
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: SelectionMenuLauncher.kCellHeight)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    
    var dataArray: [String] = []
    var completion: ((Int) -> Void)?
    var selectedIndex = -1
    
    
    override init() {
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(SelectionMenuCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func launch(dataArray array: [String], completionHandler: @escaping (Int) -> Void) {
        if let window = UIApplication.shared.keyWindow {
            
            self.selectedIndex = -1
            self.completion = completionHandler
            self.dataArray = array
            self.collectionView.reloadData()
            
            blackView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
            blackView.alpha = 0.0
            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(handleDismiss)))
            
            var height = (CGFloat(dataArray.count) * SelectionMenuLauncher.kCellHeight + 30)
            
            // Just control the maximum height
            if height > window.frame.width {
                height = window.frame.width
            }
            
            collectionView.frame = CGRect(x: 0,
                                          y: window.frame.height,
                                          width: window.frame.width,
                                          height: height)
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            self.blackView.alpha = 1.0
                            self.collectionView.frame = CGRect(x: 0,
                                                               y: window.frame.height - height,
                                                               width: self.collectionView.frame.width,
                                                               height: self.collectionView.frame.height)
                            
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseIn,
                           animations: {
                            self.blackView.alpha = 0.0
                            self.collectionView.frame = CGRect(x: 0,
                                                               y: window.frame.height,
                                                               width: self.collectionView.frame.width,
                                                               height: self.collectionView.frame.height)
            }, completion: { _ in
                if let handler = self.completion {
                    handler(self.selectedIndex)
                }
            })
        }
    }

    
    // MARK: - UICollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier,
                                                      for: indexPath) as! SelectionMenuCollectionCell
        cell.titleLabel.text = dataArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            cell?.backgroundColor = UIColor(white: 1, alpha: 1.0)
        }
        self.selectedIndex = indexPath.item
        self.perform(#selector(self.handleDismiss), with: nil, afterDelay: 0.1)
    }
}

class SelectionMenuCollectionCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 0.2))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
    }
}
