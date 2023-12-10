//
//  CustomAnimatedView.swift
//  HomeAssignment101223
//
//  Created by Aleksandr Eliseev on 10.12.2023.
//

import UIKit

final class CustomAnimatedView: UIView {
    
    override var layer: CAShapeLayer {
        get {
            return super.layer as! CAShapeLayer
        }
    }

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
        
    private class var poses: [Pose] {
            return [
                Pose(0.0, 0.000, 0.7),
                Pose(0.6, 0.500, 0.5),
                Pose(0.6, 1.000, 0.3),
                Pose(0.6, 1.500, 0.1),
                Pose(0.2, 1.875, 0.1),
                Pose(0.2, 2.250, 0.3),
                Pose(0.2, 2.625, 0.5),
                Pose(0.2, 3.000, 0.7),
            ]
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var result: RequestResult? {
        didSet {
            guard let result else { return }
            createLayer(for: result)
        }
    }
    
    func toggleAnimationVisibility(for requestResult: RequestResult?) {
        guard let requestResult
        else {
            self.stopAnimation()
            return
        }
        self.stopAnimation()
        self.isHidden = false
        self.result = requestResult
        self.startAnimation()
        print("animation started")
    }
    
    func startAnimation() {
        guard let result else { return }
        createAnimationLayer(for: layer, with: result)
    }
    
    func stopAnimation() {
        self.isHidden = true
        layer.removeAnimation(forKey: "strokeAnimation")
        layer.removeAnimation(forKey: "transform.rotation")
        layer.removeAnimation(forKey: "strokeColor")
        layer.removeAnimation(forKey: "strokeEnd")
    }
}

// MARK: - Ext UIView creation
private extension CustomAnimatedView {
    func createLayer(for result: RequestResult) {
        layer.strokeColor = UIColor.systemPink.cgColor
        layer.lineWidth = 5.0
        layer.fillColor = nil
        layer.path = createCGPath(for: result)
    }
    
    func createCGPath(for result: RequestResult) -> CGPath {
        let size = createSize()
        return createCirclePath(with: size)
    }
}

// MARK: - Ext Animation layer
private extension CustomAnimatedView {
    func createAnimationLayer(for layer: CAShapeLayer, with result: RequestResult) {
        createLoadingLayer()
    }
    
    func createResultLayer() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.9
        
        layer.add(animation, forKey: "strokeAnimation")
    }
    
    func createLoadingLayer() {
        var time: CFTimeInterval = 0
        var times = [CFTimeInterval]()
        var start: CGFloat = 0.5
        var rotations = [CGFloat]()
        var strokeEnds = [CGFloat]()

        let poses = type(of: self).poses
        let totalSeconds = poses.reduce(0) { $0 + $1.secondsSincePriorPose }

        for pose in poses {
            time += pose.secondsSincePriorPose
            times.append(time / totalSeconds)
            start = pose.start
            rotations.append(start * 2 * CGFloat.pi)
            strokeEnds.append(pose.length)
        }

        times.append(times.last!)
        rotations.append(rotations[0])
        strokeEnds.append(strokeEnds[0])

        animateKeyPath(keyPath: "strokeEnd", duration: totalSeconds, times: times, values: strokeEnds)
        animateKeyPath(keyPath: "transform.rotation", duration: totalSeconds, times: times, values: rotations)
    }
}

// MARK: - Loading Animation
private extension CustomAnimatedView {
    func animateKeyPath(keyPath: String, duration: CFTimeInterval, times: [CFTimeInterval], values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = duration
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: animation.keyPath)
    }
}


// MARK: - Ext CGPAths
private extension CustomAnimatedView {
    func createSize() -> CGSize {
        CGSize(width: bounds.width, height: bounds.height)
    }
    
    func createCirclePath(with size: CGSize) -> CGPath {
        return UIBezierPath(ovalIn: bounds).cgPath
    }
}
