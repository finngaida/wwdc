//
//  Shapes.swift
//  TastyImitationKeyboard
//
//  Created by Alexei Baboulevitch on 10/5/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import UIKit

// TODO: these shapes were traced and as such are erratic and inaccurate; should redo as SVG or PDF

///////////////////
// SHAPE OBJECTS //
///////////////////

class BackspaceShape: Shape {
    override func drawCall(color: UIColor) {
        drawBackspace(self.bounds, color: color)
    }
}

class ShiftShape: Shape {
    var withLock: Bool = false {
        didSet {
            self.overflowCanvas.setNeedsDisplay()
        }
    }
    
    override func drawCall(color: UIColor) {
        drawShift(self.bounds, color: color, withRect: self.withLock)
    }
}

class GlobeShape: Shape {
    override func drawCall(color: UIColor) {
        drawGlobe(self.bounds, color: color)
    }
}

class GearShape: Shape {
    override func drawCall(color: UIColor) {
        drawGear(self.bounds, color: color)
    }
}

class HideShape: Shape {
    override func drawCall(color: UIColor) {
        drawHide(self.bounds, color: color)
    }
}

class Shape: UIView {
    var color: UIColor? {
        didSet {
            if let _ = self.color {
                self.overflowCanvas.setNeedsDisplay()
            }
        }
    }
    
    // in case shapes draw out of bounds, we still want them to show
    var overflowCanvas: OverflowCanvas!
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        
        self.opaque = false
        self.clipsToBounds = false
        
        self.overflowCanvas = OverflowCanvas(shape: self)
        self.addSubview(self.overflowCanvas)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var oldBounds: CGRect?
    override func layoutSubviews() {
        if self.bounds.width == 0 || self.bounds.height == 0 {
            return
        }
        if oldBounds != nil && CGRectEqualToRect(self.bounds, oldBounds!) {
            return
        }
        oldBounds = self.bounds
        
        super.layoutSubviews()
        
        let overflowCanvasSizeRatio = CGFloat(1.25)
        let overflowCanvasSize = CGSizeMake(self.bounds.width * overflowCanvasSizeRatio, self.bounds.height * overflowCanvasSizeRatio)
        
        self.overflowCanvas.frame = CGRectMake(
            CGFloat((self.bounds.width - overflowCanvasSize.width) / 2.0),
            CGFloat((self.bounds.height - overflowCanvasSize.height) / 2.0),
            overflowCanvasSize.width,
            overflowCanvasSize.height)
        self.overflowCanvas.setNeedsDisplay()
    }
    
    func drawCall(color: UIColor) { /* override me! */ }
    
    class OverflowCanvas: UIView {
        unowned var shape: Shape
        
        init(shape: Shape) {
            self.shape = shape
            
            super.init(frame: CGRectZero)
            
            self.opaque = false
        }

        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect) {
            let ctx = UIGraphicsGetCurrentContext()
            CGColorSpaceCreateDeviceRGB()
            
            CGContextSaveGState(ctx)
            
            let xOffset = (self.bounds.width - self.shape.bounds.width) / CGFloat(2)
            let yOffset = (self.bounds.height - self.shape.bounds.height) / CGFloat(2)
            CGContextTranslateCTM(ctx, xOffset, yOffset)
            
            self.shape.drawCall(shape.color != nil ? shape.color! : UIColor.blackColor())
            
            CGContextRestoreGState(ctx)
        }
    }
}

/////////////////////
// SHAPE FUNCTIONS //
/////////////////////

func getFactors(fromSize: CGSize, toRect: CGRect) -> (xScalingFactor: CGFloat, yScalingFactor: CGFloat, lineWidthScalingFactor: CGFloat, fillIsHorizontal: Bool, offset: CGFloat) {
    
    let xSize = { () -> CGFloat in
        let scaledSize = (fromSize.width / CGFloat(2))
        if scaledSize > toRect.width {
            return (toRect.width / scaledSize) / CGFloat(2)
        }
        else {
            return CGFloat(0.5)
        }
    }()
    
    let ySize = { () -> CGFloat in
        let scaledSize = (fromSize.height / CGFloat(2))
        if scaledSize > toRect.height {
            return (toRect.height / scaledSize) / CGFloat(2)
        }
        else {
            return CGFloat(0.5)
        }
    }()
    
    let actualSize = min(xSize, ySize)
    let lineWidth = actualSize * 2
    
    return (actualSize, actualSize, lineWidth, false, 0)
}

func centerShape(fromSize: CGSize, toRect: CGRect) {
    let xOffset = (toRect.width - fromSize.width) / CGFloat(2)
    let yOffset = (toRect.height - fromSize.height) / CGFloat(2)
    
    let ctx = UIGraphicsGetCurrentContext()
    CGContextSaveGState(ctx)
    CGContextTranslateCTM(ctx, xOffset, yOffset)
}

func endCenter() {
    let ctx = UIGraphicsGetCurrentContext()
    CGContextRestoreGState(ctx)
}

func drawBackspace(bounds: CGRect, color: UIColor) {
    let factors = getFactors(CGSizeMake(44, 32), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor
    let lineWidthScalingFactor = factors.lineWidthScalingFactor
    
    centerShape(CGSizeMake(44 * xScalingFactor, 32 * yScalingFactor), toRect: bounds)
    
    
    //// Color Declarations
    let color = color
    let color2 = UIColor.grayColor() // TODO:
    
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(16 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(44 * xScalingFactor, 26 * yScalingFactor), controlPoint1: CGPointMake(38 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(44 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(44 * xScalingFactor, 6 * yScalingFactor), controlPoint1: CGPointMake(44 * xScalingFactor, 22 * yScalingFactor), controlPoint2: CGPointMake(44 * xScalingFactor, 6 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(36 * xScalingFactor, 0 * yScalingFactor), controlPoint1: CGPointMake(44 * xScalingFactor, 6 * yScalingFactor), controlPoint2: CGPointMake(44 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(16 * xScalingFactor, 0 * yScalingFactor), controlPoint1: CGPointMake(32 * xScalingFactor, 0 * yScalingFactor), controlPoint2: CGPointMake(16 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(16 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.closePath()
    color.setFill()
    bezierPath.fill()
    
    
    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPointMake(20 * xScalingFactor, 10 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 22 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(20 * xScalingFactor, 10 * yScalingFactor))
    bezier2Path.closePath()
    UIColor.grayColor().setFill()
    bezier2Path.fill()
    color2.setStroke()
    bezier2Path.lineWidth = 2.5 * lineWidthScalingFactor
    bezier2Path.stroke()
    
    
    //// Bezier 3 Drawing
    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPointMake(20 * xScalingFactor, 22 * yScalingFactor))
    bezier3Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 10 * yScalingFactor))
    bezier3Path.addLineToPoint(CGPointMake(20 * xScalingFactor, 22 * yScalingFactor))
    bezier3Path.closePath()
    UIColor.redColor().setFill()
    bezier3Path.fill()
    color2.setStroke()
    bezier3Path.lineWidth = 2.5 * lineWidthScalingFactor
    bezier3Path.stroke()
    
    endCenter()
}

func drawShift(bounds: CGRect, color: UIColor, withRect: Bool) {
    let factors = getFactors(CGSizeMake(38, (withRect ? 34 + 4 : 32)), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor
    _ = factors.lineWidthScalingFactor
    
    centerShape(CGSizeMake(38 * xScalingFactor, (withRect ? 34 + 4 : 32) * yScalingFactor), toRect: bounds)
    
    
    //// Color Declarations
    let color2 = color
    
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(28 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(38 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(19 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(10 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(10 * xScalingFactor, 28 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(14 * xScalingFactor, 32 * yScalingFactor), controlPoint1: CGPointMake(10 * xScalingFactor, 28 * yScalingFactor), controlPoint2: CGPointMake(10 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(24 * xScalingFactor, 32 * yScalingFactor), controlPoint1: CGPointMake(16 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(24 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(28 * xScalingFactor, 28 * yScalingFactor), controlPoint1: CGPointMake(24 * xScalingFactor, 32 * yScalingFactor), controlPoint2: CGPointMake(28 * xScalingFactor, 32 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(28 * xScalingFactor, 18 * yScalingFactor), controlPoint1: CGPointMake(28 * xScalingFactor, 26 * yScalingFactor), controlPoint2: CGPointMake(28 * xScalingFactor, 18 * yScalingFactor))
    bezierPath.closePath()
    color2.setFill()
    bezierPath.fill()
    
    
    if withRect {
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(10 * xScalingFactor, 34 * yScalingFactor, 18 * xScalingFactor, 4 * yScalingFactor))
        color2.setFill()
        rectanglePath.fill()
    }
    
    endCenter()
}

func drawGlobe(bounds: CGRect, color: UIColor) {
    let factors = getFactors(CGSizeMake(41, 40), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor
    let yScalingFactor = factors.yScalingFactor
    let lineWidthScalingFactor = factors.lineWidthScalingFactor
    
    centerShape(CGSizeMake(41 * xScalingFactor, 40 * yScalingFactor), toRect: bounds)
    
    
    //// Color Declarations
    let color = color
    
    //// Oval Drawing
    let ovalPath = UIBezierPath(ovalInRect: CGRectMake(0 * xScalingFactor, 0 * yScalingFactor, 40 * xScalingFactor, 40 * yScalingFactor))
    color.setStroke()
    ovalPath.lineWidth = 1 * lineWidthScalingFactor
    ovalPath.stroke()
    
    
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(20 * xScalingFactor, -0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, 40 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, -0 * yScalingFactor))
    bezierPath.closePath()
    color.setStroke()
    bezierPath.lineWidth = 1 * lineWidthScalingFactor
    bezierPath.stroke()
    
    
    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPointMake(0.5 * xScalingFactor, 19.5 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(39.5 * xScalingFactor, 19.5 * yScalingFactor))
    bezier2Path.addLineToPoint(CGPointMake(0.5 * xScalingFactor, 19.5 * yScalingFactor))
    bezier2Path.closePath()
    color.setStroke()
    bezier2Path.lineWidth = 1 * lineWidthScalingFactor
    bezier2Path.stroke()
    
    
    //// Bezier 3 Drawing
    let bezier3Path = UIBezierPath()
    bezier3Path.moveToPoint(CGPointMake(21.63 * xScalingFactor, 0.42 * yScalingFactor))
    bezier3Path.addCurveToPoint(CGPointMake(21.63 * xScalingFactor, 39.6 * yScalingFactor), controlPoint1: CGPointMake(21.63 * xScalingFactor, 0.42 * yScalingFactor), controlPoint2: CGPointMake(41 * xScalingFactor, 19 * yScalingFactor))
    bezier3Path.lineCapStyle = .Round;
    
    color.setStroke()
    bezier3Path.lineWidth = 1 * lineWidthScalingFactor
    bezier3Path.stroke()
    
    
    //// Bezier 4 Drawing
    let bezier4Path = UIBezierPath()
    bezier4Path.moveToPoint(CGPointMake(17.76 * xScalingFactor, 0.74 * yScalingFactor))
    bezier4Path.addCurveToPoint(CGPointMake(18.72 * xScalingFactor, 39.6 * yScalingFactor), controlPoint1: CGPointMake(17.76 * xScalingFactor, 0.74 * yScalingFactor), controlPoint2: CGPointMake(-2.5 * xScalingFactor, 19.04 * yScalingFactor))
    bezier4Path.lineCapStyle = .Round;
    
    color.setStroke()
    bezier4Path.lineWidth = 1 * lineWidthScalingFactor
    bezier4Path.stroke()
    
    
    //// Bezier 5 Drawing
    let bezier5Path = UIBezierPath()
    bezier5Path.moveToPoint(CGPointMake(6 * xScalingFactor, 7 * yScalingFactor))
    bezier5Path.addCurveToPoint(CGPointMake(34 * xScalingFactor, 7 * yScalingFactor), controlPoint1: CGPointMake(6 * xScalingFactor, 7 * yScalingFactor), controlPoint2: CGPointMake(19 * xScalingFactor, 21 * yScalingFactor))
    bezier5Path.lineCapStyle = .Round;
    
    color.setStroke()
    bezier5Path.lineWidth = 1 * lineWidthScalingFactor
    bezier5Path.stroke()
    
    
    //// Bezier 6 Drawing
    let bezier6Path = UIBezierPath()
    bezier6Path.moveToPoint(CGPointMake(6 * xScalingFactor, 33 * yScalingFactor))
    bezier6Path.addCurveToPoint(CGPointMake(34 * xScalingFactor, 33 * yScalingFactor), controlPoint1: CGPointMake(6 * xScalingFactor, 33 * yScalingFactor), controlPoint2: CGPointMake(19 * xScalingFactor, 22 * yScalingFactor))
    bezier6Path.lineCapStyle = .Round;
    
    color.setStroke()
    bezier6Path.lineWidth = 1 * lineWidthScalingFactor
    bezier6Path.stroke()
    
    endCenter()
}

func drawGear(bounds: CGRect, color: UIColor) {
    let factors = getFactors(CGSizeMake(41, 40), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor * 2
    let yScalingFactor = factors.yScalingFactor * 2
    let lineWidthScalingFactor = factors.lineWidthScalingFactor * 1.25
    
    centerShape(CGSizeMake(20 * xScalingFactor, 20 * yScalingFactor), toRect: bounds)
    
    
    //// Color Declarations
    let strokeColor = color
    
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(10 * xScalingFactor, 6.38 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(6.38 * xScalingFactor, 10 * yScalingFactor), controlPoint1: CGPointMake(8 * xScalingFactor, 6.38 * yScalingFactor), controlPoint2: CGPointMake(6.38 * xScalingFactor, 8 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(10 * xScalingFactor, 13.62 * yScalingFactor), controlPoint1: CGPointMake(6.38 * xScalingFactor, 12 * yScalingFactor), controlPoint2: CGPointMake(8 * xScalingFactor, 13.62 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(13.6 * xScalingFactor, 10 * yScalingFactor), controlPoint1: CGPointMake(12 * xScalingFactor, 13.62 * yScalingFactor), controlPoint2: CGPointMake(13.6 * xScalingFactor, 12 * yScalingFactor))
    bezierPath.addCurveToPoint(CGPointMake(10 * xScalingFactor, 6.38 * yScalingFactor), controlPoint1: CGPointMake(13.6 * xScalingFactor, 8 * yScalingFactor), controlPoint2: CGPointMake(11.99 * xScalingFactor, 6.38 * yScalingFactor))
    bezierPath.closePath()
    bezierPath.moveToPoint(CGPointMake(17.25 * xScalingFactor, 12.08 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(16.59 * xScalingFactor, 13.65 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(17.76 * xScalingFactor, 15.93 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(17.91 * xScalingFactor, 16.23 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(16.3 * xScalingFactor, 17.84 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(13.66 * xScalingFactor, 16.59 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(12.09 * xScalingFactor, 17.24 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(11.29 * xScalingFactor, 19.68 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(11.19 * xScalingFactor, 20 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(8.91 * xScalingFactor, 20 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(7.92 * xScalingFactor, 17.25 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(6.35 * xScalingFactor, 16.6 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(4.07 * xScalingFactor, 17.76 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(3.77 * xScalingFactor, 17.91 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(2.16 * xScalingFactor, 16.3 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(3.4 * xScalingFactor, 13.66 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(2.76 * xScalingFactor, 12.09 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0.32 * xScalingFactor, 11.29 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 11.19 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(0 * xScalingFactor, 8.91 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(2.75 * xScalingFactor, 7.92 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(3.4 * xScalingFactor, 6.36 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(2.24 * xScalingFactor, 4.07 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(2.09 * xScalingFactor, 3.77 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(3.7 * xScalingFactor, 2.16 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(6.35 * xScalingFactor, 3.41 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(7.91 * xScalingFactor, 2.76 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(8.71 * xScalingFactor, 0.32 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(8.81 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(11.09 * xScalingFactor, 0 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(12.07 * xScalingFactor, 2.76 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(13.64 * xScalingFactor, 3.4 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(15.93 * xScalingFactor, 2.24 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(16.23 * xScalingFactor, 2.09 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(17.84 * xScalingFactor, 3.7 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(16.59 * xScalingFactor, 6.34 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(17.24 * xScalingFactor, 7.91 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(19.68 * xScalingFactor, 8.71 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, 8.81 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(20 * xScalingFactor, 11.09 * yScalingFactor))
    bezierPath.addLineToPoint(CGPointMake(17.25 * xScalingFactor, 12.08 * yScalingFactor))
    bezierPath.closePath()
    bezierPath.miterLimit = 4;

    
    strokeColor.setStroke()
    bezierPath.lineWidth = lineWidthScalingFactor
    bezierPath.stroke()
    
    endCenter()
}

func drawHide(bounds: CGRect, color: UIColor) {
    let factors = getFactors(CGSizeMake(41, 40), toRect: bounds)
    let xScalingFactor = factors.xScalingFactor * 0.8
    let yScalingFactor = factors.yScalingFactor * 0.8
    let lineWidthScalingFactor = factors.lineWidthScalingFactor
    
    centerShape(CGSizeMake(80 * xScalingFactor, 60 * yScalingFactor), toRect: bounds)
    
    
    //// Color Declarations
    let strokeColor = color
    
    //// Abgerundetes Rechteck 1 Drawing
    let abgerundetesRechteck1Path = UIBezierPath()
    abgerundetesRechteck1Path.moveToPoint(CGPointMake(3 * xScalingFactor, 0 * yScalingFactor))
    abgerundetesRechteck1Path.addLineToPoint(CGPointMake(80 * xScalingFactor, 0 * yScalingFactor))
    abgerundetesRechteck1Path.addCurveToPoint(CGPointMake(83 * xScalingFactor, 3 * yScalingFactor), controlPoint1: CGPointMake(81.66 * xScalingFactor, 0 * yScalingFactor), controlPoint2: CGPointMake(83 * xScalingFactor, 1.34 * yScalingFactor))
    abgerundetesRechteck1Path.addLineToPoint(CGPointMake(83 * xScalingFactor, 37 * yScalingFactor))
    abgerundetesRechteck1Path.addCurveToPoint(CGPointMake(80 * xScalingFactor, 40 * yScalingFactor), controlPoint1: CGPointMake(83 * xScalingFactor, 38.66 * yScalingFactor), controlPoint2: CGPointMake(81.66 * xScalingFactor, 40 * yScalingFactor))
    abgerundetesRechteck1Path.addLineToPoint(CGPointMake(3 * xScalingFactor, 40 * yScalingFactor))
    abgerundetesRechteck1Path.addCurveToPoint(CGPointMake(0 * xScalingFactor, 37 * yScalingFactor), controlPoint1: CGPointMake(1.34 * xScalingFactor, 40 * yScalingFactor), controlPoint2: CGPointMake(0 * xScalingFactor, 38.66 * yScalingFactor))
    abgerundetesRechteck1Path.addLineToPoint(CGPointMake(0 * xScalingFactor, 3 * yScalingFactor))
    abgerundetesRechteck1Path.addCurveToPoint(CGPointMake(3 * xScalingFactor, 0 * yScalingFactor), controlPoint1: CGPointMake(0 * xScalingFactor, 1.34 * yScalingFactor), controlPoint2: CGPointMake(1.34 * xScalingFactor, 0 * yScalingFactor))
    abgerundetesRechteck1Path.closePath()
    strokeColor.setStroke()
    abgerundetesRechteck1Path.lineWidth = lineWidthScalingFactor
    abgerundetesRechteck1Path.stroke()
    
    
    //// Abgerundetes Rechteck 2 Drawing
    let abgerundetesRechteck2Path = UIBezierPath()
    abgerundetesRechteck2Path.moveToPoint(CGPointMake(25.06 * xScalingFactor, 45.89 * yScalingFactor))
    abgerundetesRechteck2Path.addLineToPoint(CGPointMake(41.54 * xScalingFactor, 59.71 * yScalingFactor))
    abgerundetesRechteck2Path.addCurveToPoint(CGPointMake(41.62 * xScalingFactor, 62.18 * yScalingFactor), controlPoint1: CGPointMake(42.24 * xScalingFactor, 60.3 * yScalingFactor), controlPoint2: CGPointMake(42.27 * xScalingFactor, 61.41 * yScalingFactor))
    abgerundetesRechteck2Path.addCurveToPoint(CGPointMake(39.17 * xScalingFactor, 62.53 * yScalingFactor), controlPoint1: CGPointMake(40.97 * xScalingFactor, 62.96 * yScalingFactor), controlPoint2: CGPointMake(39.87 * xScalingFactor, 63.12 * yScalingFactor))
    abgerundetesRechteck2Path.addLineToPoint(CGPointMake(22.7 * xScalingFactor, 48.71 * yScalingFactor))
    abgerundetesRechteck2Path.addCurveToPoint(CGPointMake(22.61 * xScalingFactor, 46.23 * yScalingFactor), controlPoint1: CGPointMake(22 * xScalingFactor, 48.12 * yScalingFactor), controlPoint2: CGPointMake(21.96 * xScalingFactor, 47.01 * yScalingFactor))
    abgerundetesRechteck2Path.addCurveToPoint(CGPointMake(25.06 * xScalingFactor, 45.89 * yScalingFactor), controlPoint1: CGPointMake(23.27 * xScalingFactor, 45.46 * yScalingFactor), controlPoint2: CGPointMake(24.36 * xScalingFactor, 45.3 * yScalingFactor))
    abgerundetesRechteck2Path.closePath()
    strokeColor.setFill()
    abgerundetesRechteck2Path.fill()
    
    
    //// Abgerundetes Rechteck 2 Kopie Drawing
    let abgerundetesRechteck2KopiePath = UIBezierPath()
    abgerundetesRechteck2KopiePath.moveToPoint(CGPointMake(56.08 * xScalingFactor, 46.35 * yScalingFactor))
    abgerundetesRechteck2KopiePath.addLineToPoint(CGPointMake(39.56 * xScalingFactor, 59.88 * yScalingFactor))
    abgerundetesRechteck2KopiePath.addCurveToPoint(CGPointMake(39.47 * xScalingFactor, 62.29 * yScalingFactor), controlPoint1: CGPointMake(38.86 * xScalingFactor, 60.45 * yScalingFactor), controlPoint2: CGPointMake(38.82 * xScalingFactor, 61.53 * yScalingFactor))
    abgerundetesRechteck2KopiePath.addCurveToPoint(CGPointMake(41.93 * xScalingFactor, 62.63 * yScalingFactor), controlPoint1: CGPointMake(40.13 * xScalingFactor, 63.05 * yScalingFactor), controlPoint2: CGPointMake(41.23 * xScalingFactor, 63.21 * yScalingFactor))
    abgerundetesRechteck2KopiePath.addLineToPoint(CGPointMake(58.46 * xScalingFactor, 49.11 * yScalingFactor))
    abgerundetesRechteck2KopiePath.addCurveToPoint(CGPointMake(58.54 * xScalingFactor, 46.69 * yScalingFactor), controlPoint1: CGPointMake(59.16 * xScalingFactor, 48.53 * yScalingFactor), controlPoint2: CGPointMake(59.2 * xScalingFactor, 47.45 * yScalingFactor))
    abgerundetesRechteck2KopiePath.addCurveToPoint(CGPointMake(56.08 * xScalingFactor, 46.35 * yScalingFactor), controlPoint1: CGPointMake(57.89 * xScalingFactor, 45.93 * yScalingFactor), controlPoint2: CGPointMake(56.79 * xScalingFactor, 45.78 * yScalingFactor))
    abgerundetesRechteck2KopiePath.closePath()
    strokeColor.setFill()
    abgerundetesRechteck2KopiePath.fill()
    
    
    //// Top
    //// Rechteck 1 Drawing
    let rechteck1Path = UIBezierPath()
    rechteck1Path.moveToPoint(CGPointMake(7 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Path.addLineToPoint(CGPointMake(13 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Path.addLineToPoint(CGPointMake(13 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Path.addLineToPoint(CGPointMake(7 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Path.addLineToPoint(CGPointMake(7 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Path.closePath()
    strokeColor.setFill()
    rechteck1Path.fill()
    
    
    //// Rechteck 1 Kopie Drawing
    let rechteck1KopiePath = UIBezierPath()
    rechteck1KopiePath.moveToPoint(CGPointMake(16 * xScalingFactor, 7 * yScalingFactor))
    rechteck1KopiePath.addLineToPoint(CGPointMake(22 * xScalingFactor, 7 * yScalingFactor))
    rechteck1KopiePath.addLineToPoint(CGPointMake(22 * xScalingFactor, 13 * yScalingFactor))
    rechteck1KopiePath.addLineToPoint(CGPointMake(16 * xScalingFactor, 13 * yScalingFactor))
    rechteck1KopiePath.addLineToPoint(CGPointMake(16 * xScalingFactor, 7 * yScalingFactor))
    rechteck1KopiePath.closePath()
    strokeColor.setFill()
    rechteck1KopiePath.fill()
    
    
    //// Rechteck 1 Kopie 2 Drawing
    let rechteck1Kopie2Path = UIBezierPath()
    rechteck1Kopie2Path.moveToPoint(CGPointMake(25 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie2Path.addLineToPoint(CGPointMake(31 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie2Path.addLineToPoint(CGPointMake(31 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie2Path.addLineToPoint(CGPointMake(25 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie2Path.addLineToPoint(CGPointMake(25 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie2Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie2Path.fill()
    
    
    //// Rechteck 1 Kopie 3 Drawing
    let rechteck1Kopie3Path = UIBezierPath()
    rechteck1Kopie3Path.moveToPoint(CGPointMake(34 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie3Path.addLineToPoint(CGPointMake(40 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie3Path.addLineToPoint(CGPointMake(40 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie3Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie3Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie3Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie3Path.fill()
    
    
    //// Rechteck 1 Kopie 4 Drawing
    let rechteck1Kopie4Path = UIBezierPath()
    rechteck1Kopie4Path.moveToPoint(CGPointMake(43 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie4Path.addLineToPoint(CGPointMake(49 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie4Path.addLineToPoint(CGPointMake(49 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie4Path.addLineToPoint(CGPointMake(43 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie4Path.addLineToPoint(CGPointMake(43 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie4Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie4Path.fill()
    
    
    //// Rechteck 1 Kopie 5 Drawing
    let rechteck1Kopie5Path = UIBezierPath()
    rechteck1Kopie5Path.moveToPoint(CGPointMake(52 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie5Path.addLineToPoint(CGPointMake(58 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie5Path.addLineToPoint(CGPointMake(58 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie5Path.addLineToPoint(CGPointMake(52 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie5Path.addLineToPoint(CGPointMake(52 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie5Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie5Path.fill()
    
    
    //// Rechteck 1 Kopie 6 Drawing
    let rechteck1Kopie6Path = UIBezierPath()
    rechteck1Kopie6Path.moveToPoint(CGPointMake(61 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie6Path.addLineToPoint(CGPointMake(67 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie6Path.addLineToPoint(CGPointMake(67 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie6Path.addLineToPoint(CGPointMake(61 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie6Path.addLineToPoint(CGPointMake(61 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie6Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie6Path.fill()
    
    
    //// Rechteck 1 Kopie 7 Drawing
    let rechteck1Kopie7Path = UIBezierPath()
    rechteck1Kopie7Path.moveToPoint(CGPointMake(70 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie7Path.addLineToPoint(CGPointMake(76 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie7Path.addLineToPoint(CGPointMake(76 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie7Path.addLineToPoint(CGPointMake(70 * xScalingFactor, 13 * yScalingFactor))
    rechteck1Kopie7Path.addLineToPoint(CGPointMake(70 * xScalingFactor, 7 * yScalingFactor))
    rechteck1Kopie7Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie7Path.fill()
    
    
    
    
    //// Middle
    //// Rechteck Drawing
    let rechteckPath = UIBezierPath()
    rechteckPath.moveToPoint(CGPointMake(7 * xScalingFactor, 17 * yScalingFactor))
    rechteckPath.addLineToPoint(CGPointMake(13 * xScalingFactor, 17 * yScalingFactor))
    rechteckPath.addLineToPoint(CGPointMake(13 * xScalingFactor, 23 * yScalingFactor))
    rechteckPath.addLineToPoint(CGPointMake(7 * xScalingFactor, 23 * yScalingFactor))
    rechteckPath.addLineToPoint(CGPointMake(7 * xScalingFactor, 17 * yScalingFactor))
    rechteckPath.closePath()
    strokeColor.setFill()
    rechteckPath.fill()
    
    
    //// Rechteck 1 Kopie 8 Drawing
    let rechteck1Kopie8Path = UIBezierPath()
    rechteck1Kopie8Path.moveToPoint(CGPointMake(16 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie8Path.addLineToPoint(CGPointMake(22 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie8Path.addLineToPoint(CGPointMake(22 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie8Path.addLineToPoint(CGPointMake(16 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie8Path.addLineToPoint(CGPointMake(16 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie8Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie8Path.fill()
    
    
    //// Rechteck 1 Kopie 9 Drawing
    let rechteck1Kopie9Path = UIBezierPath()
    rechteck1Kopie9Path.moveToPoint(CGPointMake(25 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie9Path.addLineToPoint(CGPointMake(31 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie9Path.addLineToPoint(CGPointMake(31 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie9Path.addLineToPoint(CGPointMake(25 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie9Path.addLineToPoint(CGPointMake(25 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie9Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie9Path.fill()
    
    
    //// Rechteck 1 Kopie 10 Drawing
    let rechteck1Kopie10Path = UIBezierPath()
    rechteck1Kopie10Path.moveToPoint(CGPointMake(34 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie10Path.addLineToPoint(CGPointMake(40 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie10Path.addLineToPoint(CGPointMake(40 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie10Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie10Path.addLineToPoint(CGPointMake(34 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie10Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie10Path.fill()
    
    
    //// Rechteck 1 Kopie 11 Drawing
    let rechteck1Kopie11Path = UIBezierPath()
    rechteck1Kopie11Path.moveToPoint(CGPointMake(43 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie11Path.addLineToPoint(CGPointMake(49 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie11Path.addLineToPoint(CGPointMake(49 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie11Path.addLineToPoint(CGPointMake(43 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie11Path.addLineToPoint(CGPointMake(43 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie11Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie11Path.fill()
    
    
    //// Rechteck 1 Kopie 12 Drawing
    let rechteck1Kopie12Path = UIBezierPath()
    rechteck1Kopie12Path.moveToPoint(CGPointMake(52 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie12Path.addLineToPoint(CGPointMake(58 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie12Path.addLineToPoint(CGPointMake(58 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie12Path.addLineToPoint(CGPointMake(52 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie12Path.addLineToPoint(CGPointMake(52 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie12Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie12Path.fill()
    
    
    //// Rechteck 1 Kopie 13 Drawing
    let rechteck1Kopie13Path = UIBezierPath()
    rechteck1Kopie13Path.moveToPoint(CGPointMake(61 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie13Path.addLineToPoint(CGPointMake(67 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie13Path.addLineToPoint(CGPointMake(67 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie13Path.addLineToPoint(CGPointMake(61 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie13Path.addLineToPoint(CGPointMake(61 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie13Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie13Path.fill()
    
    
    //// Rechteck 1 Kopie 14 Drawing
    let rechteck1Kopie14Path = UIBezierPath()
    rechteck1Kopie14Path.moveToPoint(CGPointMake(70 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie14Path.addLineToPoint(CGPointMake(76 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie14Path.addLineToPoint(CGPointMake(76 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie14Path.addLineToPoint(CGPointMake(70 * xScalingFactor, 23 * yScalingFactor))
    rechteck1Kopie14Path.addLineToPoint(CGPointMake(70 * xScalingFactor, 17 * yScalingFactor))
    rechteck1Kopie14Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie14Path.fill()
    
    
    
    
    //// Bottom
    //// Rechteck 2 Drawing
    let rechteck2Path = UIBezierPath()
    rechteck2Path.moveToPoint(CGPointMake(7 * xScalingFactor, 27 * yScalingFactor))
    rechteck2Path.addLineToPoint(CGPointMake(13 * xScalingFactor, 27 * yScalingFactor))
    rechteck2Path.addLineToPoint(CGPointMake(13 * xScalingFactor, 33 * yScalingFactor))
    rechteck2Path.addLineToPoint(CGPointMake(7 * xScalingFactor, 33 * yScalingFactor))
    rechteck2Path.addLineToPoint(CGPointMake(7 * xScalingFactor, 27 * yScalingFactor))
    rechteck2Path.closePath()
    strokeColor.setFill()
    rechteck2Path.fill()
    
    
    //// Rechteck 1 Kopie 15 Drawing
    let rechteck1Kopie15Path = UIBezierPath()
    rechteck1Kopie15Path.moveToPoint(CGPointMake(16 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie15Path.addLineToPoint(CGPointMake(22 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie15Path.addLineToPoint(CGPointMake(22 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie15Path.addLineToPoint(CGPointMake(16 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie15Path.addLineToPoint(CGPointMake(16 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie15Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie15Path.fill()
    
    
    //// Rechteck 1 Kopie 16 Drawing
    let rechteck1Kopie16Path = UIBezierPath()
    rechteck1Kopie16Path.moveToPoint(CGPointMake(25 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie16Path.addLineToPoint(CGPointMake(58 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie16Path.addLineToPoint(CGPointMake(58 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie16Path.addLineToPoint(CGPointMake(25 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie16Path.addLineToPoint(CGPointMake(25 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie16Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie16Path.fill()
    
    
    //// Rechteck 1 Kopie 17 Drawing
    let rechteck1Kopie17Path = UIBezierPath()
    rechteck1Kopie17Path.moveToPoint(CGPointMake(61 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie17Path.addLineToPoint(CGPointMake(67 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie17Path.addLineToPoint(CGPointMake(67 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie17Path.addLineToPoint(CGPointMake(61 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie17Path.addLineToPoint(CGPointMake(61 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie17Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie17Path.fill()
    
    
    //// Rechteck 1 Kopie 18 Drawing
    let rechteck1Kopie18Path = UIBezierPath()
    rechteck1Kopie18Path.moveToPoint(CGPointMake(70 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie18Path.addLineToPoint(CGPointMake(76 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie18Path.addLineToPoint(CGPointMake(76 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie18Path.addLineToPoint(CGPointMake(70 * xScalingFactor, 33 * yScalingFactor))
    rechteck1Kopie18Path.addLineToPoint(CGPointMake(70 * xScalingFactor, 27 * yScalingFactor))
    rechteck1Kopie18Path.closePath()
    strokeColor.setFill()
    rechteck1Kopie18Path.fill()
    
    endCenter()
}

