//
//  DotView.swift
//  layOutLine<.>view
//
//  Created by Anh vũ on 5/19/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

@IBDesignable
class DotView: UIView, DotViewProtocol {
    var lineStyle: LineStyle = .dot
    
    var lineWeight: CGFloat = 2
    
    var lineColor: UIColor = UIColor.darkGray
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addLine(at: .top, rect: rect)
    }
}

enum LinePosition {
    case top
    case bottom
    case left
    case right
    
    func getOriginPoint(rect: CGRect, delta: CGFloat) -> CGPoint {
        switch self {
        case .top:
            return CGPoint(x: 0, y: delta)
        case  .left:
            return CGPoint(x: delta, y: 0)
        case .right:
            return CGPoint(x: rect.maxX - delta, y: rect.maxY)
        case .bottom:
            return CGPoint(x: rect.maxX, y: rect.maxY - delta)
        }
    }
    
    func getEndPoint(rect: CGRect, delta: CGFloat) -> CGPoint {
        switch self {
        case .top:
            return CGPoint(x: rect.maxX, y: delta)
        case .left :
            return CGPoint(x: delta, y: rect.maxY)
        case .right:
            return CGPoint(x: rect.maxX - delta, y: 0)
        case .bottom:
            return CGPoint(x: rect.minX, y: rect.maxY - delta)
        }
    }
}

enum LineStyle {
    case line
    case dot
    case dash
}

protocol DotViewProtocol {
    var lineWeight : CGFloat {get set}
    var lineColor: UIColor{get set}
    var lineStyle: LineStyle{get set}
    func addLine(at position: LinePosition, rect: CGRect)
}


extension DotViewProtocol {
    func addLine(at position: LinePosition, rect: CGRect) {
        let path = UIBezierPath()
        path.move(to:position.getOriginPoint(rect: rect, delta: lineWeight / 2))
        path.addLine(to: position.getEndPoint(rect: rect,  delta: lineWeight / 2))
        path.lineWidth = lineWeight
        switch lineStyle {
        case .line:
            break
        case .dot:
            let dash : [CGFloat] = [lineWeight, lineWeight * 1.2]
            path.setLineDash(dash, count: 2, phase: 0)
        case .dash:
            let dash : [CGFloat] = [lineWeight, lineWeight * 1.4]
            path.setLineDash(dash, count: 3, phase: 0)
        }
        
        lineColor.setStroke()
        path.stroke()
    }
}
