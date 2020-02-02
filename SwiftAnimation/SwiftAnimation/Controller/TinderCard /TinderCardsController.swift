//
//  TinderCardsController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 01/02/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class TinderCardsController: UIViewController, SwipeCardViewProtocol {

    // MARK: - Variables
    lazy private var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "refresh_circle"), for: .normal)
        button.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var nopeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nope_circle"), for: .normal)
        button.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var superLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "super_like_circle"), for: .normal)
        button.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like_circle"), for: .normal)
        button.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var boostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "boost_circle"), for: .normal)
        button.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private let cardContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var users: [TinderUser] = []
    private var cards: [SwipeCardView] = []
    private var cardInitialLocationCenter: CGPoint!
    private var panInitialLocation: CGPoint!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = UIColor(red: 243, green: 243, blue: 243)
        edgesForExtendedLayout = []
        
        let stackView = UIStackView(arrangedSubviews: [refreshButton, nopeButton, superLikeButton, likeButton, boostButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        view.addSubviews(stackView, cardContainerView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(75)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        cardContainerView.snp.makeConstraints { (make) in
            make.left.top.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(stackView.snp.top).offset(-40)
        }
        
        users = TinderUser.users()
        
        DispatchQueue.main.async {
            self.users.forEach { (tinderUser) in
                self.setupCard(user: tinderUser)
            }
        }
    }
    
    private func setupCard(user: TinderUser) {
        let cardView = SwipeCardView(frame: cardContainerView.bounds)
        cardView.user = user
        cardView.delegate = self
        cards.append(cardView)
        cardContainerView.addSubview(cardView)
        cardContainerView.sendSubviewToBack(cardView)
        
        setupTransforms()
        
        if cards.count == 1 {
            // saving initial center and adding pan gesture on top most card view
            cardInitialLocationCenter = cardView.center
            cardView.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                                 action: #selector(pan(gesture:))))
        }
    }
    
    func setupTransforms() {
        for (index, card) in cards.enumerated() {
            
            // ignore for top most card view
            if index == 0 { continue }
            
            // add transform for only few cards behind the top most card
            if index > 3 { return }
            
            var transform = CGAffineTransform.identity
            if index % 2 == 0 {
                // transforming to right side
                transform = transform.translatedBy(x: CGFloat(index) * 4, y: 0)
                transform = transform.rotated(by: CGFloat(Double.pi) / 150 * CGFloat(index))
            } else {
                // transforming to left side
                transform = transform.translatedBy(x: -CGFloat(index) * 4, y: 0)
                transform = transform.rotated(by: -CGFloat(Double.pi) / 150 * CGFloat(index))
            }
            card.transform = transform
        }
    }
    
    @objc private func handleAction(_ sender: UIButton) {
        
        switch sender {
        
        case self.likeButton:
            guard let _ = cards.first else {
                return
            }
            swipeAnimation(translation: 750, angle: 15)
            self.setupTransforms()
            
        case self.nopeButton:
            guard let _ = cards.first else {
                return
            }
            swipeAnimation(translation: -750, angle: -15)
            self.setupTransforms()
            
        default: break
        }
    }
    
    func swipeAnimation(translation: CGFloat, angle: CGFloat) {
        let duration = 0.5
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle * CGFloat.pi / 180
        rotationAnimation.duration = duration
        guard let firstCard = cards.first else {
            return
        }
        for (index, c) in self.cards.enumerated() {
            if c.user.userId == firstCard.user.userId {
                self.cards.remove(at: index)
                self.users.remove(at: index)
            }
        }
        
        self.setupGestures()
        
        CATransaction.setCompletionBlock {
            firstCard.removeFromSuperview()
        }
        firstCard.layer.add(translationAnimation, forKey: "translation")
        firstCard.layer.add(rotationAnimation, forKey: "rotation")
        CATransaction.commit()
    }
    
    func setupGestures() {
        
        for card in cards {
            let gestures = card.gestureRecognizers ?? []
            gestures.forEach { (gesture) in
                card.removeGestureRecognizer(gesture)
            }
        }
        
        if let firstCard = cards.first {
            firstCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:))))
        }
    }
    
    @objc func pan(gesture: UIPanGestureRecognizer) {
        let card = gesture.view! as! SwipeCardView
        let translation = gesture.translation(in: cardContainerView)
        
        switch gesture.state {
        case .began:
            panInitialLocation = gesture.location(in: cardContainerView)
            print(panInitialLocation!)

        case .changed:
            card.center.x = cardInitialLocationCenter.x + translation.x
            card.center.y = cardInitialLocationCenter.y + translation.y
            
            if translation.x > 0 {
                // show like icon
                // 0<= alpha <=1
                card.likeView.alpha = abs(translation.x * 2) / cardContainerView.bounds.midX
                card.nopeView.alpha = 0
            } else {
                // show unlike icon
                card.nopeView.alpha = abs(translation.x * 2) / cardContainerView.bounds.midX
                card.likeView.alpha = 0
            }
            
            card.transform = self.transform(view: card, for: translation)

        case .ended:
            
            if translation.x > 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: self.cardInitialLocationCenter.x + 1000, y: self.cardInitialLocationCenter.y + 1000)
                }) { (bool) in
                    // remove card
                    card.removeFromSuperview()
                }
                self.updateCards(card: card)

                return
            } else if translation.x < -75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: self.cardInitialLocationCenter.x - 1000, y: self.cardInitialLocationCenter.y + 1000)
                }) { (bool) in
                    // remove card
                    card.removeFromSuperview()
                }
                self.updateCards(card: card)
                return
            }
            
            UIView.animate(withDuration: 0.3) {
                card.center = self.cardInitialLocationCenter
                card.likeView.alpha = 0
                card.nopeView.alpha = 0
                card.transform = CGAffineTransform.identity
            }
            
        default: break
        }
    }
    
    func updateCards(card: SwipeCardView) {
        for (index, c) in self.cards.enumerated() {
            if c.user.userId == card.user.userId {
                self.cards.remove(at: index)
                self.users.remove(at: index)
            }
        }
        setupGestures()
        setupTransforms()
    }
    
    func transform(view: UIView, for translation: CGPoint) -> CGAffineTransform {
        let moveBy = CGAffineTransform(translationX: translation.x, y: translation.y)
        let rotation = -translation.x / (view.frame.width / 2)
        return moveBy.rotated(by: rotation)
    }
    
    // MARK: - Delegates
    func didUserInfoTapped(user: TinderUser) {
        print("perform your action on click user card view....")
    }
}
