//
//  ProgressIndicator.swift
//  Progress Indicator Swift
//
//  Created by Dan on 23/08/2014.
//
//

import UIKit

@IBDesignable
class ProgressIndicator: UIControl {
    
    // MARK: Properties
    
    @IBInspectable
    var steps:Int = 3 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var selectedStep:Int = -1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var indicatorSize:CGFloat = 14.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineWidth:CGFloat = 1.0 {
        didSet {
            self.adjustEdgeInsets()
            self.setNeedsDisplay()
        }
    }
    
    var edgeInsets:UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            self.adjustEdgeInsets()
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.adjustEdgeInsets()
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.adjustEdgeInsets()
    }
    
    func adjustEdgeInsets() {
        if (self.edgeInsets.top < self.lineWidth/2) {
            edgeInsets = UIEdgeInsetsMake(self.lineWidth/2, self.edgeInsets.left, self.edgeInsets.bottom, self.edgeInsets.right)
            self.setNeedsDisplay()
        }
        if (self.edgeInsets.left < self.lineWidth/2) {
            edgeInsets = UIEdgeInsetsMake(self.edgeInsets.top, self.lineWidth/2, self.edgeInsets.bottom, self.edgeInsets.right);
            self.setNeedsDisplay()
        }
        if (self.edgeInsets.bottom < self.lineWidth/2) {
            edgeInsets = UIEdgeInsetsMake(self.edgeInsets.top, self.edgeInsets.left, self.lineWidth/2, self.edgeInsets.right);
            self.setNeedsDisplay()
        }
        if (self.edgeInsets.right < self.lineWidth/2) {
            edgeInsets = UIEdgeInsetsMake(self.edgeInsets.top, self.edgeInsets.left, self.edgeInsets.bottom, self.lineWidth/2);
            self.setNeedsDisplay()
        }
    }
    
    // MARK: Drawing
    
    func pathForStepWithIndex(step: Int) -> (UIBezierPath) {
        var delta = Float(self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.indicatorSize)
        var offset = Float(step) * (delta / Float(self.steps - 1))
        var x = CGFloat( Double(self.edgeInsets.left) + Double(offset))
        
        return UIBezierPath(ovalInRect:CGRectMake(x, self.edgeInsets.top, self.indicatorSize, self.indicatorSize))
    }
    
    func linePathForStepWithIndex(step: Int) -> (UIBezierPath) {
        var delta = (Double(self.frame.size.width) - Double(self.edgeInsets.left) - Double(self.edgeInsets.right) - Double(self.indicatorSize)) / Double(self.steps - 1)
        var offset = Double(step) * delta
        var path = UIBezierPath()
        
        var x = Double(self.edgeInsets.left) + Double(self.indicatorSize) + offset
        var y = Double(self.edgeInsets.top) + Double(self.indicatorSize / 2)
        
        path.moveToPoint(CGPoint(x:x, y:y))
        
        x = Double(self.edgeInsets.left) + Double(offset) + Double(delta)
        y = Double(self.edgeInsets.top) + Double(self.indicatorSize / 2)
        
        path.addLineToPoint(CGPoint(x:x, y:y))
        
        return path;
    }
    
    override func drawRect(rect: CGRect) {
        self.tintColor.setStroke()
        
        for var i = 0; i < self.steps - 1; i++ {
            var linePath = self.linePathForStepWithIndex(i)
            linePath.lineWidth = self.lineWidth
            linePath.stroke()
        }
        
        for var i = 0; i < self.steps; i++ {
            var path = self.pathForStepWithIndex(i)
            
            (i == self.selectedStep) ? self.tintColor.setFill() : UIColor.clearColor().setFill();
            path.fill();
            
            path.lineWidth = self.lineWidth
            path.stroke()
        }
    }
}
