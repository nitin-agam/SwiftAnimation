//
//  SelectionMenuController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 17/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class SelectionMenuController: UIViewController {

    // MARK: - Variables
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy private var menuLauncher: SelectionMenuLauncher = {
        let launcher = SelectionMenuLauncher()
        return launcher
    }()
    
    private let kCategories = ["Mobiles",
                               "Computers",
                               "Sports",
                               "Cars",
                               "Men's Fashion",
                               "Women's Fashion",
                               "Baby's Wear",
                               "Electronics",
                               "Home Decorations"]
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        let selectButton = UIButton(type: .system)
        selectButton.setTitle("Select Category", for: .normal)
        selectButton.addTarget(self, action: #selector(handleCategorySelection), for: .touchUpInside)
        selectButton.backgroundColor = .kAppColor
        selectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.layer.cornerRadius = 5
        selectButton.layer.masksToBounds = true
        view.addSubviews(selectButton, categoryNameLabel)
        selectButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        categoryNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectButton.snp.bottom).offset(20)
        }
    }
    
    @objc private func handleCategorySelection() {
        menuLauncher.launch(dataArray: kCategories) { (index) in
            if index > -1 {
                self.categoryNameLabel.text = self.kCategories[index]
            }
        }
    }
}
