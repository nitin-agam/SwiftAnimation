//
//  FitnessExercise.swift
//  SwiftAnimation
//
//  Created by Nitin A on 18/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class FitnessExercise {
    
    var title = ""
    var backgroundImage: UIImage
    
    init(title: String, bgImage: String) {
        self.title = title
        self.backgroundImage = UIImage(named: bgImage)!
    }
    
    static func fetchExercises() -> [FitnessExercise] {
        return [
            FitnessExercise(title: "No pain, no gain. Shut up and train.", bgImage: "fitness_1"),
            FitnessExercise(title: "Your body can stand almost anything.", bgImage: "fitness_2"),
            FitnessExercise(title: "Success isn’t always about greatness. It’s about consistency.", bgImage: "fitness_3"),
            FitnessExercise(title: "Train insane or remain the same.", bgImage: "fitness_4"),
            FitnessExercise(title: "Push yourself because no one else is going to do it for you.", bgImage: "fitness_5"),
            FitnessExercise(title: "Success starts with self-discipline.", bgImage: "fitness_6")
        ]
    }
}
