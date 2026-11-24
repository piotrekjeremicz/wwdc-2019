//
//  Extensions.swift
//  Computer Test
//
//  Created by Piotrek on 21/03/2019.
//  Copyright © 2019 Jeremicz. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

public extension UIBezierPath {
    
    public static func withArrowFromPoint(startPoint:CGPoint,
                                          endPoint:CGPoint,
                                          tailWidth:CGFloat,
                                          headWidth:CGFloat,
                                          headLength:CGFloat) -> UIBezierPath {
        let kArrowPointCount = 7
        let length = CGFloat(hypotf(Float(endPoint.x) - Float(startPoint.x), Float(endPoint.y) - Float(startPoint.y)))
        
        
        var points = [CGPoint]()
        
        axisAlignedArrowPoints(points: &points, length: length, tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        var transform = transformFor(startPoint: startPoint, endPoint: endPoint, length: length)
        
        let cgPath = CGMutablePath()
        
        cgPath.addLines(between: points, transform: transform)
        cgPath.closeSubpath()
        let uiPath = UIBezierPath(cgPath: cgPath)
        return uiPath
        
    }
        
    private static func axisAlignedArrowPoints(points:inout [CGPoint],
                                               length:CGFloat,
                                               tailWidth:CGFloat,
                                               headWidth:CGFloat,
                                               headLength:CGFloat) {
        let tailLength = length - headLength
        
        points.append(CGPoint(x: 0, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: headLength/2))
        points.append(CGPoint(x: length, y: 0))
        points.append(CGPoint(x: tailLength, y: -headWidth/2))
        points.append(CGPoint(x: tailLength, y: -tailWidth/2))
        points.append(CGPoint(x: 0, y: -tailWidth/2))
        
    }
    
    private static func transformFor(startPoint:CGPoint, endPoint:CGPoint, length:CGFloat) -> CGAffineTransform {
        let cosine = (endPoint.x - startPoint.x)/length
        let sine = (endPoint.y - startPoint.y)/length
        
        var myAffineTransform = CGAffineTransform()
        myAffineTransform.a = cosine
        myAffineTransform.b = sine
        myAffineTransform.c = -sine
        myAffineTransform.d = cosine
        myAffineTransform.tx = startPoint.x
        myAffineTransform.ty = startPoint.y
        
        return myAffineTransform
    }
}

extension SCNNode {
    public class func lineNode(from: SCNVector3, to: SCNVector3, radius: CGFloat = 0.0125, color: UIColor = .white) -> SCNNode {
        let vector = to - from
        let height = vector.length()
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(height))
        cylinder.radialSegmentCount = 4
        
        let node = SCNNode(geometry: cylinder)
        node.position = (to + from) / 2
        node.geometry?.firstMaterial?.diffuse.contents = color
        node.eulerAngles = SCNVector3.lineEulerAngles(vector: vector)
        return node
    }
}

extension SCNVector3 {
    public static func lineEulerAngles(vector: SCNVector3) -> SCNVector3 {
        let height = vector.length()
        let lxz = sqrtf(vector.x * vector.x + vector.z * vector.z)
        let pitchB = vector.y < 0 ? Float.pi - asinf(lxz/height) : asinf(lxz/height)
        let pitch = vector.z == 0 ? pitchB : sign(vector.z) * pitchB
        
        var yaw: Float = 0
        if vector.x != 0 || vector.z != 0 {
            let inner = vector.x / (height * sinf(pitch))
            if inner > 1 || inner < -1 {
                yaw = Float.pi / 2
            } else {
                yaw = asinf(inner)
            }
        }
        return SCNVector3(CGFloat(pitch), CGFloat(yaw), 0)
    }
    
    public static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    public static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    public static func / (vector: SCNVector3, scalar: Float) -> SCNVector3 {
        return SCNVector3Make(vector.x / scalar, vector.y / scalar, vector.z / scalar)
    }
    
    public func length() -> Float {
        return sqrtf(x*x + y*y + z*z)
    }

}
