//
//  AnimationListController.swift
//  SwiftAnimation
//
//  Created by Nitin A on 07/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class AnimationListController: UITableViewController {

    // MARK: - Variables
    private let kCellIdentifier = "AnimationCell"
    private let animationListArray = ["Pulsing Animation"]
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Animations"
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animationListArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        cell.textLabel?.text = animationListArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let controller = PulsingAnimationController()
            controller.title = animationListArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        default: break
        }
    }
    
}
