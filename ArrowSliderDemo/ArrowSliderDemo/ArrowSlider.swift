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
    var chunkHeight:CGFloat = 90
    var selectedColor:UIColor = UIColor.black
    var unselectColor:UIColor = UIColor.red
    var direction:ArrowDirection = .ArrowDirectionHorizontal
    
    private var chunkCircleSize:CGFloat = 0
    
    func calcYByValue() -> CGFloat {
        return CGFloat(frame.height - chunkHeight)/CGFloat(maxValue)*CGFloat(value) + chunkHeight/2;
    }
    
    func calcValueByY() -> Int {
        return Int(CGFloat(chunk.center.y - chunkHeight/2)/(CGFloat(frame.height - chunkHeight)/CGFloat(maxValue)))
    }
    
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
            let selected_point = CGPoint(x: rect.width/2, y: rect.height/2)
            
            let chunkCircleHead = UIBezierPath(ovalIn: CGRect(x: selected_point.x - rect.height/6, y: selected_point.y - rect.height/2 + 1, width: rect.height/3, height: rect.height/3))
            chunkCircleHead.close()
            selectedColor.set()
            chunkCircleHead.stroke()
            UIColor.white.set()
            chunkCircleHead.fill()
            
            let chunkCircleTail = UIBezierPath(ovalIn: CGRect(x: selected_point.x - rect.height/6, y: selected_point.y + rect.height/6 - 1, width: rect.height/3, height: rect.height/3))
            chunkCircleTail.close()
            
            selectedColor.set()
            chunkCircleTail.stroke()
            UIColor.white.set()
            chunkCircleTail.fill()
            
            let chunkRect = UIBezierPath(rect: CGRect(x: selected_point.x - rect.height/6, y: selected_point.y - rect.height/3, width: rect.height/3, height: rect.height/3*2))
            chunkRect.close()
            
            UIColor.white.set()
            chunkRect.fill()
            
            let chunkRectBounds = UIBezierPath()
            chunkRectBounds.lineWidth = 0.5
            chunkRectBounds.move(to: CGPoint(x: selected_point.x - rect.height/6, y: selected_point.y - rect.height/3))
            chunkRectBounds.addLine(to: CGPoint(x: selected_point.x - rect.height/6, y: selected_point.y + rect.height/3))
            chunkRectBounds.move(to: CGPoint(x: selected_point.x + rect.height/6, y: selected_point.y - rect.height/3))
            chunkRectBounds.addLine(to: CGPoint(x: selected_point.x + rect.height/6, y: selected_point.y + rect.height/3))
            selectedColor.set()
            chunkRectBounds.stroke()
            
            let chunkCircle = UIBezierPath(ovalIn: CGRect(x: selected_point.x - rect.height/6 + 3, y: selected_point.y - rect.height/6 + 3, width: rect.height/3 - 6, height: rect.height/3 - 6))
            chunkCircle.close()
            selectedColor.set()
            chunkCircle.stroke()
            
            let arrowTop:UIBezierPath = UIBezierPath()
            arrowTop.lineWidth = 2
            arrowTop.move(to: CGPoint(x: selected_point.x - 10, y: selected_point.y - rect.height/3))
            arrowTop.addLine(to: CGPoint(x: selected_point.x + 1, y: selected_point.y - rect.height/2 + 5))
            arrowTop.move(to: CGPoint(x: selected_point.x, y: selected_point.y - rect.height/2 + 5))
            arrowTop.addLine(to: CGPoint(x: selected_point.x + 10, y: selected_point.y - rect.height/3))
            selectedColor.set()
            arrowTop.stroke()
            arrowTop.close()
            UIColor.white.set()
            arrowTop.fill()
            
            let arrowBottom:UIBezierPath = UIBezierPath()
            arrowBottom.lineWidth = 2
            arrowBottom.move(to: CGPoint(x: selected_point.x - 10, y: selected_point.y + rect.height/3))
            arrowBottom.addLine(to: CGPoint(x: selected_point.x + 1, y: selected_point.y + rect.height/2 - 5))
            arrowBottom.move(to: CGPoint(x: selected_point.x, y: selected_point.y + rect.height/2 - 5))
            arrowBottom.addLine(to: CGPoint(x: selected_point.x + 10, y: selected_point.y + rect.height/3))
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
        
        chunkCircleSize = chunkHeight/3
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
            
            if chunk.frame.origin.y > self.frame.height - chunkHeight {
                chunk.frame.origin.y = self.frame.height - chunkHeight
            }
            pan.setTranslation(CGPoint(x:0, y:0) , in: chunk)
            
            // 根据chunk的y值，计算value
            let value = calcValueByY()
            print("value:\(value)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chunk.frame.size = CGSize(width: chunkHeight/3 + 10, height: chunkHeight)
        chunk.center = CGPoint(x: frame.width/2, y: calcYByValue())
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
