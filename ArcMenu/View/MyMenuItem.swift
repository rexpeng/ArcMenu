//
//  MyMenuItem.swift
//  erp_ios
//
//  Created by Rex Peng on 2019/6/25.
//  Copyright © 2019 Rex Peng. All rights reserved.
//

import UIKit

class MyMenuItem: UIView {
    
    var icon: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    var number: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    var content: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    var unit: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    var color: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let baseScale: CGFloat = 80.0
    
//    override init(frame: CGRect) { //}, icon: String, number: String, content: String, unit: String) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    init(width: CGFloat, icon: UIImage?, number: String?, content: String?, unit: String?, color: UIColor?) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        self.icon = icon
        self.number = number
        self.content = content
        self.unit = unit
        self.color = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard rect != .zero else {
            return
        }
        
        let scale = min(rect.width, rect.height) / baseScale
        
        var y:CGFloat = 8
        
        let bgLayer = CALayer()
        let image = icon?.cgImage
        bgLayer.frame = rect
        bgLayer.contents = image
        layer.addSublayer(bgLayer)
        
        
        let iconSize = CGSize(width: 12*scale, height: 12*scale)
        let iconLayer = CALayer()
        iconLayer.frame = CGRect(x: (rect.width-iconSize.width)*0.5, y: y, width: iconSize.width, height: iconSize.height)
        iconLayer.contents = icon?.cgImage
        layer.addSublayer(iconLayer)        
        y += iconSize.height
        //y += 2

        let numberFont = UIFont.systemFont(ofSize: 20*scale)
        let numberLabel = UILabel()
        numberLabel.font = numberFont
        numberLabel.text = number
        numberLabel.sizeToFit()
        let numberWidth = numberLabel.frame.width
        let numberHeight = numberLabel.frame.height
        let numberLayer = CATextLayer()
        numberLayer.frame = CGRect(x: (rect.width-numberWidth)*0.5-2, y: y, width: numberWidth+4, height: numberHeight)
        numberLayer.foregroundColor = color?.cgColor
        numberLayer.font = CGFont(numberFont.fontName as CFString)
        numberLayer.fontSize = numberFont.pointSize
        numberLayer.alignmentMode = .center
        numberLayer.string = number
        layer.addSublayer(numberLayer)
        y += numberHeight - 3
        //y += 2
        
        let contentFont = UIFont.systemFont(ofSize: 12*scale)
        let contentLabel = UILabel()
        contentLabel.font = contentFont
        contentLabel.text = content
        contentLabel.sizeToFit()
        let contentWidth = contentLabel.frame.width
        let contentHeight = contentLabel.frame.height
        let contentLayer = CATextLayer()
        contentLayer.frame = CGRect(x: (rect.width-contentWidth)*0.5-2, y: y, width: contentWidth+4, height: contentHeight)
        contentLayer.foregroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1).cgColor
        contentLayer.font = CGFont(contentFont.fontName as CFString)
        contentLayer.fontSize = contentFont.pointSize
        contentLayer.alignmentMode = .center
        contentLayer.string = content
        layer.addSublayer(contentLayer)
        y += contentHeight

        let unitFont = UIFont.systemFont(ofSize: 11*scale)
        let unitLabel = UILabel()
        unitLabel.font = unitFont
        unitLabel.text = unit
        unitLabel.sizeToFit()
        let unitWidth = unitLabel.frame.width
        let unitHeight = unitLabel.frame.height
        let unitLayer = CATextLayer()
        unitLayer.frame = CGRect(x: (rect.width-unitWidth)*0.5-2, y: y, width: unitWidth+4, height: unitHeight)
        unitLayer.foregroundColor = color?.cgColor
        unitLayer.font = CGFont(unitFont.fontName as CFString)
        unitLayer.fontSize = unitFont.pointSize
        unitLayer.alignmentMode = .center
        unitLayer.string = unit
        layer.addSublayer(unitLayer)
    }

}
