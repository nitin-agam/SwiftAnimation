//
//  FitnessExercise.swift
//  SwiftAnimation
//
//  Created by Nitin A on 18/04/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

struct FitnessExercise {
    
    let title: String
    let imageName: String
    
    static func fetchExercises() -> [FitnessExercise] {
        return [
            FitnessExercise(title: "No pain, no gain. Shut up and train.", imageName: "fitness_1"),
            FitnessExercise(title: "Your body can stand almost anything.", imageName: "fitness_2"),
            FitnessExercise(title: "Success isn’t always about greatness. It’s about consistency.", imageName: "fitness_3"),
            FitnessExercise(title: "Train insane or remain the same.", imageName: "fitness_4"),
            FitnessExercise(title: "Push yourself because no one else is going to do it for you.", imageName: "fitness_5"),
            FitnessExercise(title: "Success starts with self-discipline.", imageName: "fitness_6")
        ]
    }
}
