//
//  InteractiveAnimatorController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 19/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class InteractiveAnimatorController: UIViewController {
    
    private enum CardState {
        case expanded
        case collapsed
    }
    
    // MARK: - Variables
    private var cardViewController: InteractiveCardController!
    private var blueView = UIVisualEffectView()
    private let cardHeight: CGFloat = UIScreen.main.bounds.height * 0.7
    private let showCardHandleAreaHeight: CGFloat = 60
    private var cardVisible = false
    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    private var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        
        let backgroundImageView = UIImageView(image: UIImage(named: "fitness_2"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubviews(backgroundImageView, blueView)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        blueView.frame = view.frame
        
        cardViewController = InteractiveCardController()
        addChild(cardViewController)
        view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0,
                                               y: self.view.frame.height - showCardHandleAreaHeight,
                                               width: view.frame.width,
                                               height: cardHeight)
        cardViewController.view.clipsToBounds = true
        
        cardViewController.readButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCardTapGesture(recognizer:))))
        cardViewController.readButton.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPanGesture(recognizer:))))
    }
    
    @objc private func handleCardTapGesture(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
            case .ended: self.animateTransitionIfNeeded(state: nextState, duration: 0.9)
            default: break
        }
        self.cardViewController.readButton.setTitle(self.cardVisible ? "Read" : "Close", for: .normal)
    }
    
    @objc private func handleCardPanGesture(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: self.nextState, duration: 0.7)
            
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.readButton)
            var fractionCompleted = translation.y / cardHeight
            fractionCompleted = cardVisible ? fractionCompleted : -fractionCompleted
            updateInteractiveTransition(fractionCompleted: fractionCompleted)
            
        case .ended: continueInteractiveTransition()
        default: break
        }
    }
    
    
    private func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.showCardHandleAreaHeight
                    
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                }
            }
            
            frameAnimator.addCompletion { (_) in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .collapsed: self.cardViewController.view.layer.cornerRadius = 0.0
                case .expanded: self.cardViewController.view.layer.cornerRadius = 12.0
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .collapsed: self.blueView.effect = nil
                case .expanded: self.blueView.effect = UIBlurEffect(style: .dark)
                }
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    private func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        runningAnimations.forEach { (animator) in
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        runningAnimations.forEach { (animator) in
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        runningAnimations.forEach { (animator) in
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
        self.cardViewController.readButton.setTitle(self.cardVisible ? "Read" : "Close", for: .normal)
    }
}
