//
//  PulsingAnimationController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 07/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

// https://i.picsum.photos/id/1/2000/3000.jpg
// http://www.peoplelikeus.org/piccies/codpaste/codpaste-teachingpack.pdf

class PulsingAnimationController: UIViewController {

    // MARK: - Variables
    private var circleShapeLayer: CAShapeLayer!
    private var pulsingLayer: CAShapeLayer!
    private let fileUrlString = "http://www.pdf995.com/samples/pdf.pdf"
    fileprivate var isDownloading = false
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Start"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()

    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupCircles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Adding notification to continue the pulsing animation when app will come in foreground from background.
        setupNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Private Methods
    private func setupNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc private func handleEnterForeground() {
        pulsingLayerAnimate()
    }
    
    private func initialSetup() {
        view.backgroundColor = UIColor.kPulsingBackground
    }
    
    // Return a shapre layer in circle shape.
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let circlePath = UIBezierPath(arcCenter: .zero,
                                      radius: 100,
                                      startAngle: 0,
                                      endAngle: 2 * CGFloat.pi,
                                      clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circlePath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 15.0
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        layer.position = view.center
        return layer
    }
    
    private func setupCircles() {
        
        // Setup pulsing animate layer
        pulsingLayer = createCircleShapeLayer(strokeColor: UIColor.clear,
                                              fillColor: UIColor.kPulsingFill.withAlphaComponent(0.3))
        view.layer.addSublayer(pulsingLayer)
        pulsingLayerAnimate()
        
        
        // Setup track layer
        let trackLayer = createCircleShapeLayer(strokeColor: UIColor.kTrackStroke,
                                                fillColor: UIColor.kPulsingBackground)
        view.layer.addSublayer(trackLayer)
        
        
        // Setup circle outline layer
        circleShapeLayer = createCircleShapeLayer(strokeColor: UIColor.kOutlineStroke,
                                                  fillColor: UIColor.clear)
        circleShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        circleShapeLayer.strokeEnd = 0.0
        view.layer.addSublayer(circleShapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(handleTapGesture)))
        
        // Setup percentage label
        setupPercentageLabel()
    }
    
    private func setupPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func handleTapGesture() {
        if isDownloading == false {
            beginDownloadFile()
        }
    }
    
    fileprivate func pulsingLayerAnimate() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.toValue = 1.4
        pulseAnimation.duration = 0.8
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        pulsingLayer.add(pulseAnimation, forKey: "pulsing")
    }
    
    fileprivate func drawCircleWithAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        circleShapeLayer.add(animation, forKey: "pulsingAnimation")
    }
    
    private func beginDownloadFile() {
        circleShapeLayer.strokeEnd = 0
        percentageLabel.text = "Starting..."
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration,
                                    delegate: self,
                                    delegateQueue: operationQueue)
        
        if let url = URL(string: fileUrlString) {
            let downloadTask = urlSession.downloadTask(with: url)
            downloadTask.resume()
            self.isDownloading = true
        }
    }
}

extension PulsingAnimationController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.circleShapeLayer.strokeEnd = percentage
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        isDownloading = false
    }
}
