//
//  ArrowSlider.swift
//  ArrowSliderDemo
//
//  Created by FanFamily on 16/12/31.
//  Copyright © 2016年 niuniu. All rights reserved.
//

import UIKit

enum ArrowDirection {
    case ArrowDirectionHorizontal
    case ArrowDirectionVertical
}

class ArrowSlider: UIView {

    var maxValue:Int = 500
    var value:Int = 0
    var selectedColor:UIColor = UIColor.black
    var unselectColor:UIColor = UIColor.red
    var direction:ArrowDirection = .ArrowDirectionHorizontal
    
    class ArrowSliderChunk:UIView {
        
        var selectedColor:UIColor = UIColor.blue
        var centerPosition:CGFloat = 0.0
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = UIColor.clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            let selected_point = CGPoint(x: rect.width/2, y: centerPosition)
            
            let chunkCircleHead = UIBezierPath(ovalIn: CGRect(x: selected_point.x - 15, y: selected_point.y - 45, width: 30.0, height: 30.0))
            chunkCircleHead.close()
            selectedColor.set()
            chunkCircleHead.stroke()
            UIColor.white.set()
            chunkCircleHead.fill()
            
            let chunkCircleTail = UIBezierPath(ovalIn: CGRect(x: selected_point.x - 15, y: selected_point.y + 15, width: 30.0, height: 30.0))
            chunkCircleTail.close()
            
            selectedColor.set()
            chunkCircleTail.stroke()
            UIColor.white.set()
            chunkCircleTail.fill()
            
            let chunkRect = UIBezierPath(rect: CGRect(x: selected_point.x - 15, y: selected_point.y - 30, width: 30.0, height: 60.0))
            chunkRect.close()
            
            UIColor.white.set()
            chunkRect.fill()
            
            let chunkRectBounds = UIBezierPath()
            chunkRectBounds.lineWidth = 0.5
            chunkRectBounds.move(to: CGPoint(x: selected_point.x - 15.2, y: selected_point.y - 30))
            chunkRectBounds.addLine(to: CGPoint(x: selected_point.x - 15.2, y: selected_point.y + 30))
            chunkRectBounds.move(to: CGPoint(x: selected_point.x + 15.2, y: selected_point.y - 30))
            chunkRectBounds.addLine(to: CGPoint(x: selected_point.x + 15.2, y: selected_point.y + 30))
            selectedColor.set()
            chunkRectBounds.stroke()
            
            let chunkCircle = UIBezierPath(ovalIn: CGRect(x: selected_point.x - 12, y: selected_point.y - 12, width: 24.0, height: 24.0))
            chunkCircle.close()
            selectedColor.set()
            chunkCircle.stroke()
            
            let arrowTop:UIBezierPath = UIBezierPath()
            arrowTop.lineWidth = 2
            arrowTop.move(to: CGPoint(x: selected_point.x - 10, y: selected_point.y - 30))
            arrowTop.addLine(to: CGPoint(x: selected_point.x + 1, y: selected_point.y - 40))
            arrowTop.move(to: CGPoint(x: selected_point.x, y: selected_point.y - 40))
            arrowTop.addLine(to: CGPoint(x: selected_point.x + 10, y: selected_point.y - 30))
            selectedColor.set()
            arrowTop.stroke()
            arrowTop.close()
            UIColor.white.set()
            arrowTop.fill()
            
            let arrowBottom:UIBezierPath = UIBezierPath()
            arrowBottom.lineWidth = 2
            arrowBottom.move(to: CGPoint(x: selected_point.x - 10, y: selected_point.y + 30))
            arrowBottom.addLine(to: CGPoint(x: selected_point.x + 1, y: selected_point.y + 40))
            arrowBottom.move(to: CGPoint(x: selected_point.x, y: selected_point.y + 40))
            arrowBottom.addLine(to: CGPoint(x: selected_point.x + 10, y: selected_point.y + 30))
            selectedColor.set()
            arrowBottom.stroke()
            arrowBottom.close()
            UIColor.white.set()
            arrowBottom.fill()
        }
    }
    
    let chunk:ArrowSliderChunk = ArrowSliderChunk()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        
        chunk.selectedColor = selectedColor
        addSubview(chunk)
        let pan = UIPanGestureRecognizer(target: self, action:#selector(didDragged(pan:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        chunk.addGestureRecognizer(pan)
    }
    
    func didDragged(pan:UIPanGestureRecognizer) {
        if pan.state == .changed || pan.state == .ended {
            let offset  = pan.translation(in: chunk)
            chunk.center = CGPoint(x: chunk.center.x, y: chunk.center.y + offset.y)
            print("\(chunk.center)")
            if chunk.frame.origin.y < 0 {
                chunk.frame.origin.y = 0
            }
            
            if chunk.frame.origin.y > self.frame.height - 90 {
                chunk.frame.origin.y = self.frame.height - 90            }
            pan.setTranslation(CGPoint(x:0, y:0) , in: chunk)
            
            
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        chunk.frame = frame
        
        chunk.centerPosition = CGFloat(frame.height - 90)/CGFloat(maxValue)*CGFloat(value) + 45
    }
    
    override func draw(_ rect: CGRect) {
        let unselected = UIBezierPath()
        unselected.move(to: CGPoint(x: rect.width/2, y: 0))
        unselected.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
        unselected.close()
        
        unselectColor.set()
        unselected.stroke()
        unselected.fill()
        
        let selected = UIBezierPath()
        selected.move(to: CGPoint(x: rect.width/2, y: 0))
        let selected_point = CGPoint(x: rect.width/2, y: chunk.centerPosition)
        selected.addLine(to: selected_point)
        selected.close()
        
        selectedColor.set()
        selected.stroke()
        selected.fill()
    }
    
}
