//
//  ArcMenu.swift
//  testfortest
//
//  Created by Rex Peng on 2019/6/20.
//  Copyright © 2019 Rex Peng. All rights reserved.
//

import UIKit

protocol ArcMenuDelegate {
    func menu(_ menu: ArcMenu, didSelectAt index: Int)
}

class ArcMenu: UIView {
    
    private let itemsContainerView = UIView()
    private var menuItems: [UIView] = []
    
    private var _center: CGPoint = .zero
    private var radius: CGFloat = 0
    private var leftAngle: CGFloat = 0
    private var rightAngle: CGFloat = 0
    private var lastItemAngle: CGFloat = 0
    
    private var offsetAngle: CGFloat = 21
    var itemOffset: CGFloat = 40
    
    private var panGesture: UIPanGestureRecognizer?
    private var originPoint = CGPoint()
    private var originRotation: CGFloat = 0.0
    
    var delegate: ArcMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let p1 = CGPoint(x: 0+itemOffset, y: rect.maxY-itemOffset)
        let p2 = CGPoint(x: rect.maxX * 0.5, y: rect.maxY * 0.5)
        let p3 = CGPoint(x: rect.maxX-itemOffset, y: rect.maxY-itemOffset)
        
        let tmpa1 = p1.x-p2.x
        let tmpb1 = p1.y-p2.y
        let tmpc1 = (pow(p1.x, 2)-pow(p2.x,2)+pow(p1.y,2)-pow(p2.y,2))/2
        
        let tmpa2 = p3.x-p2.x
        let tmpb2 = p3.y-p2.y
        let tmpc2 = (pow(p3.x,2)-pow(p2.x,2)+pow(p3.y,2)-pow(p2.y,2))/2
        
        let tmp = tmpa1 * tmpb2 - tmpa2 * tmpb1
        var x: CGFloat
        var y: CGFloat
        if tmp == 0 {
            x = p1.x
            y = p1.y
        } else {
            x = (tmpc1 * tmpb2 - tmpc2 * tmpb1) / tmp
            y = (tmpa1 * tmpc2 - tmpa2 * tmpc1) / tmp
        }
        
        _center = CGPoint(x: x, y: y)
        
        radius = sqrt(pow(_center.x-p2.x,2)+pow(_center.y-p2.y, 2))
        
        let circlePath = UIBezierPath(arcCenter: _center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        let circleLayer = CAShapeLayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: rect.width, height: radius*2)
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.lineWidth = 1
        circleLayer.position =  CGPoint(x: _center.x, y: _center.y-rect.maxY*0.5)
        
        #if DEBUG
        layer.addSublayer(circleLayer)
        #endif
        
        leftAngle = 360 - getAngle(point: p1, center: _center, radius: radius)
        rightAngle = getAngle(point: p3, center: _center, radius: radius) + 360
        offsetAngle = (rightAngle - leftAngle) / 2.5 // 畫面上顯示item的數量
        
        addItemsContainerView()
        addGesture()
        
        setItems()
    }
    
    func getAngle(point: CGPoint, center: CGPoint, radius: CGFloat) -> CGFloat {
        let _sin = abs(point.x-center.x) / radius
        let angle = asin(_sin) / CGFloat.pi * 180
        return angle
    }

    
    private func getPoint(angle: CGFloat, center: CGPoint, radius: CGFloat) -> CGPoint {
        var mAngle = angle - 90.0
        if mAngle > 180.0 {
            mAngle = mAngle - 360.0
        }
        mAngle = mAngle * CGFloat.pi / 180.0
        let x = center.x + radius * cos(mAngle)
        let y = center.y + radius * sin(mAngle)
        return CGPoint(x: x, y: y)
    }
    
    private func getAngle(angle: CGFloat) -> CGFloat {
        return angle * CGFloat.pi / 180.0
    }
    
    private func transformToAngle(rotation: CGFloat) -> CGFloat {
        return rotation*(180.0/CGFloat.pi)
    }
    
    func setMenuItem(items: [UIView]) {
        for item in menuItems {
            item.removeFromSuperview()
        }

        menuItems.removeAll()
        
        for i in 0..<items.count {
            let item = items[i]
            itemOffset = item.bounds.width * 0.5
            let rect = CGRect(x: 0, y: 0, width: itemOffset*2, height: itemOffset*2)
            item.frame = rect
            item.tag = i
            let tap = UITapGestureRecognizer(target: self, action: #selector(onItemClicked(_:)))
            item.addGestureRecognizer(tap)
            item.isUserInteractionEnabled = true
            itemsContainerView.addSubview(item)
            menuItems.append(item)
        }
        
        setNeedsDisplay()
    }
    
    @objc func onItemClicked(_ recognizer: UIPanGestureRecognizer) {
        if let tag = recognizer.view?.tag {
            delegate?.menu(self, didSelectAt: tag)
            print("item \(tag) selected")
        }
    }
    
    func setItems() {
        for i in 0..<menuItems.count {
            lastItemAngle = leftAngle + CGFloat(i) * offsetAngle
            let point = getPoint(angle: lastItemAngle, center: _center, radius: radius)
            let item = menuItems[i]
            item.center = point
            item.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    private func addGesture() {
        if panGesture == nil {
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
            panGesture?.minimumNumberOfTouches = 1
            panGesture?.maximumNumberOfTouches = 1
            addGestureRecognizer(panGesture!)
        }
    }
    
    @objc private func panAction(_ recognizer: UIPanGestureRecognizer) {
        guard menuItems.count > 0 else { return }
        
        switch recognizer.state {
        case .began:
            originPoint = recognizer.location(in: self)
            for item in menuItems {
                item.isUserInteractionEnabled = false
            }
            
        case .changed:
            for item in menuItems {
                item.isUserInteractionEnabled = false
            }
            let changeX = recognizer.location(in: self).x - originPoint.x
            placeItems(dX: changeX)
            originPoint = recognizer.location(in: self)
            
        case .ended:
            for item in menuItems {
                item.isUserInteractionEnabled = true
            }
            springBack()
            
        default:
            break
        }
    }
    
    func placeItems(dX: CGFloat) {
        let value = originRotation + dX
        let angle = getAngle(angle: value)
        originRotation = value
        
        itemsContainerView.transform = CGAffineTransform(rotationAngle: angle)
        for item in menuItems {
            item.transform = CGAffineTransform(rotationAngle: -angle)
        }
    }
    
    private func springBack() {
        let la = leftAngle + transformToAngle(rotation: getAngle(angle:originRotation))
        let ra = lastItemAngle + transformToAngle(rotation: getAngle(angle:originRotation))
        if la > leftAngle {
            doSpringbackAnimation(0)
        } else if ra < lastItemAngle && ra < rightAngle {
            doSpringbackAnimation(getAngle(angle:rightAngle-lastItemAngle))
        }

    }
    
    fileprivate func doSpringbackAnimation(_ value: CGFloat) {
        
        UIView.animate(withDuration: 0.5) {
            self.itemsContainerView.transform = CGAffineTransform(rotationAngle: value)
            
            self.originRotation = self.transformToAngle(rotation: value)

            for item in self.menuItems {
                item.transform = CGAffineTransform(rotationAngle: -value)
            }
        }
        
    }
    
    private func addItemsContainerView() {
        itemsContainerView.removeFromSuperview()

        itemsContainerView.frame = CGRect(x: _center.x-radius, y: _center.y-radius, width: radius*2, height: radius*2)
        itemsContainerView.clipsToBounds = false
        itemsContainerView.backgroundColor = UIColor.clear
        addSubview(itemsContainerView)
        itemsContainerView.bounds = CGRect(x: _center.x-radius, y: _center.y-radius, width: radius*2, height: radius*2)
        print(itemsContainerView.frame)
    }
}
