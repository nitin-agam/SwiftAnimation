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
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var menuLauncher: SelectionMenuLauncher = {
        let launcher = SelectionMenuLauncher()
        return launcher
    }()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        
        let selectButton = UIButton(type: .system)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.setTitle("Select Category", for: .normal)
        selectButton.addTarget(self, action: #selector(handleCategorySelection), for: .touchUpInside)
        view.addSubview(selectButton)
        
        selectButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(categoryNameLabel)
        categoryNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryNameLabel.topAnchor.constraint(equalTo: selectButton.bottomAnchor, constant: 30).isActive = true
    }
    
    @objc private func handleCategorySelection() {
        let categories = ["Mobiles", "Computers", "Sports", "Cars", "Men's Fashion", "Women's Fashion", "Baby's Wear", "Electronics", "Home Decorations"]
        menuLauncher.launch(dataArray: categories) { (index) in
            if index > -1 {
                self.categoryNameLabel.text = categories[index]
            }
        }
    }
}
