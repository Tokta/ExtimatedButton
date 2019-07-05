//
// ExtimatedButton.swift
//
// Created by Alessio Sardella on 04/07/2019.
// Copyright 2019 Lepaya <http://www.lepaya.com>. All rights reserved.
//
// swiftlint:disable force_unwrapping

import UIKit

enum ImagePosition {
    case right
    case left
}

class ExtimatedButton: UIView {
    
    static public var font: UIFont = UIFont.systemFont(ofSize: 12)
    static private var xpad: CGFloat = 10
    static private var ypad: CGFloat = 5
    static private var xintraPad: CGFloat = 6
    
    private var xpad: CGFloat {
        return ExtimatedButton.xpad
    }
    private var ypad: CGFloat {
        return ExtimatedButton.ypad
    }
    private var xintraPad: CGFloat {
        return ExtimatedButton.xintraPad
    }
    
    private var font: UIFont = ExtimatedButton.font
    private var title: String = ""
    private var imageName: String = ""
    
    private var label: UILabel?
    private var image: UIImageView?
    public var textColor: UIColor = .white {
        didSet {
            self.label?.textColor = self.textColor
        }
    }
    
    init(position: CGPoint, height: CGFloat, title: String, imageName: String, imagePosition: ImagePosition, font: UIFont = ExtimatedButton.font) {
        
        super.init(frame: CGRect(x: position.x, y: position.y, width: 0, height: height))
        
        self.title = title
        self.imageName = imageName
        self.font = font
        
        if imagePosition == .right {
            self.addLabel()
            self.addImage()
            self.frame.size.width = image!.frame.origin.x + image!.frame.size.width + xpad
        } else {
            self.addImage()
            self.addLabel()
            self.frame.size.width = label!.frame.origin.x + label!.frame.size.width + xpad
        }
    }
    
    func addLabel() {
        
        let labelWidth = ExtimatedButton.extimatedLabelWidth(title: self.title, height: self.bounds.height, font: self.font)
        var xPosition = xpad
        if let image = self.image {
            xPosition = image.frame.origin.x + image.frame.size.width + xintraPad
        }
        self.label = UILabel(frame: CGRect(x: xPosition, y: 0, width: labelWidth, height: self.bounds.height))
        self.label?.text = self.title
        self.label?.textColor = self.textColor
        self.label?.font = self.font
        addSubview(self.label!)
    }
    
    func addImage() {
        
        var xPosition = xpad
        if let label = self.label {
            xPosition = label.frame.origin.x + label.frame.size.width + xintraPad
        }
        
        let imageWidth: CGFloat = self.bounds.height - 2*ypad
        image = UIImageView(frame: CGRect(x: xPosition,
                                          y: ypad,
                                          width: imageWidth,
                                          height: imageWidth))
        image?.image = UIImage(named: self.imageName)
        image?.contentMode = .center
        addSubview(image!)
    }
    // swiftlint:enable force_unwrapping
    
    func addAction(closure: @escaping UIButtonTargetClosure) {
        let button = UIButton(frame: self.bounds)
        button.addTargetClosure(closure: closure)
        addSubview(button)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension ExtimatedButton {
    
    private static func extimatedLabelWidth(title: String, height: CGFloat, font: UIFont = ExtimatedButton.font) -> CGFloat {
        
        let estimation = ((title as NSString).boundingRect(with: CGSize(width: 0, height: height),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          attributes: [NSAttributedString.Key.font: font],
                                                          context: nil))
        return estimation.width
    }
    
    public static func extimatedWidth(title: String, height: CGFloat, font: UIFont = ExtimatedButton.font) -> CGFloat {
        let labelWidthEstimation = ExtimatedButton.extimatedLabelWidth(title: title, height: height, font: font)
        let imageWidthEstimation = height - 2*ExtimatedButton.ypad
        return labelWidthEstimation + imageWidthEstimation + 2*ExtimatedButton.xpad + ExtimatedButton.xintraPad
    }
}

typealias UIButtonTargetClosure = (UIButton) -> Void

class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}
