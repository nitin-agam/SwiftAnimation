//
//  CarouselEffectController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 18/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class CarouselEffectController: UICollectionViewController {

    // MARK: - Variables
    private let reuseIdentifier = "CarouselCollectionCell"
    private let cellScale: CGFloat = 0.8
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale) * 0.9
        let marginX = (screenSize.width - cellWidth) / 2.0
        let marginY = (screenSize.height - cellHeight) / 2.0
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: marginY, left: marginX, bottom: marginY, right: marginY)
        collectionView.backgroundColor = .clear
        collectionView!.register(CarouselCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    

    // MARK: - UICollectionView Methods
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FitnessExercise.fetchExercises().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CarouselCollectionCell
        cell.exercise = FitnessExercise.fetchExercises()[indexPath.item]
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthWithSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


