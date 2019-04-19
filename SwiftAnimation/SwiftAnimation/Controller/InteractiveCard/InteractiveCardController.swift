//
//  InteractiveCardController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 19/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class InteractiveCardController: UIViewController {

    // MARK: - Variables
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.isEditable = false
        return tv
    }()
    
    lazy var readButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(r: 255, g: 204, b: 0)
        button.setTitle("Read", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        
        view.addSubview(readButton)
        readButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        readButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        readButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        readButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(contentTextView)
        contentTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        contentTextView.topAnchor.constraint(equalTo: readButton.bottomAnchor, constant: 0).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        
        
        let content = "Physical activity or exercise can improve your health and reduce the risk of developing several diseases like type 2 diabetes, cancer and cardiovascular disease. Physical activity and exercise can have immediate and long-term health benefits. Most importantly, regular activity can improve your quality of life. A minimum of 30 minutes a day can allow you to enjoy these benefits.\n\nTo maintain health and reduce your risk of health problems, health professionals and researchers recommend a minimum of 30 minutes of moderate-intensity physical activity on most, preferably all, days.\n\nPre-exercise screening is used to identify people with medical conditions that may put them at a higher risk of experiencing a health problem during physical activity. It is a filter or ‘safety net’ to help decide if the potential benefits of exercise outweigh the risks for you"
    
        let contentParagraph = NSMutableParagraphStyle()
        contentParagraph.lineSpacing = 10
        let attributedText = NSAttributedString(string: content, attributes: [NSAttributedString.Key.paragraphStyle: contentParagraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        self.contentTextView.attributedText = attributedText
    }
}
