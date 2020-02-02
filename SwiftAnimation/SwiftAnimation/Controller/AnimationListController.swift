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
    private let animationListArray = ["Pulsing Animation",
                                      "Selection Menu",
                                      "Carousel Effect",
                                      "Interactive Card",
                                      "Tinder Cards"]
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Animations"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        tableView.rowHeight = 60
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animationListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
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
            
        case 1:
            let controller = SelectionMenuController()
            controller.title = animationListArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        case 2:
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let controller = CarouselEffectController(collectionViewLayout: layout)
            controller.title = animationListArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        case 3:
            let controller = InteractiveAnimatorController()
            controller.title = animationListArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        case 4:
            let controller = TinderCardsController()
            controller.title = animationListArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        default: break
        }
    }
    
}
