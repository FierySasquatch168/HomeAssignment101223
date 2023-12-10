//
//  Pose.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import Foundation

struct Pose {
    let secondsSincePriorPose: CFTimeInterval
    let start: CGFloat
    let length: CGFloat
    init(_ secondsSincePriorPose: CFTimeInterval, _ start: CGFloat, _ length: CGFloat) {
        self.secondsSincePriorPose = secondsSincePriorPose
        self.start = start
        self.length = length
    }
}
