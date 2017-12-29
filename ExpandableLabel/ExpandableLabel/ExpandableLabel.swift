//
//  ExpandableLabel.swift
//  ExpandableLabel
//
//  Created by user on 12/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

enum LabelState {
    case expanded
    case collapsed
}

class ExpandableLabel: UIView {
    
    private var expandedBottomConstraint = NSLayoutConstraint()
    private var collapsedBottomConstraint = NSLayoutConstraint()
    
    var state: LabelState = .collapsed {
        didSet {
            switch state {
            case .expanded:
                button.isHidden = false
                label.numberOfLines = 0
            case .collapsed:
                button.isHidden = true
                label.numberOfLines = 4
            }
        }
    }
    
    var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.brown
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.addSubview(label)
        self.addSubview(button)
        setupConstraints()
        addActions()
    }
    
    func setupConstraints() {
        let topConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        collapsedBottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, collapsedBottomConstraint, leftConstraint, rightConstraint])
        
        expandedBottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let heightButtonConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        let widthButtonConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let rightButtonConstraint = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomButtonConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([heightButtonConstraint, widthButtonConstraint, rightButtonConstraint, bottomButtonConstraint])
        
        state = .collapsed
    }
    
    func addActions() {
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    @objc func buttonTap() {
        switch state {
        case .expanded:
            expandedBottomConstraint.isActive = true
            collapsedBottomConstraint.isActive = false
        case .collapsed:
            expandedBottomConstraint.isActive = false
            collapsedBottomConstraint.isActive = true
        }
    }
    
    func setState() {

        self.state = numberOfLinesNew() > 4 ? .expanded : .collapsed
    }

    
    var text: String = "" {
        didSet{
            label.text = text
            setState()
        }
    }
    
    func numberOfLinesNew() -> Int {
        
        var size: CGSize = CGSize()
        if let text = label.text{
            size = label.font.sizeOfString(string: text, constrainedToWidth: Double(self.frame.height))
        }
//        let textSize = CGSize(width: CGFloat(label.frame.size.width), height: CGFloat(MAXFLOAT))
//        let rHeight: Int = lroundf(Float(label.sizeThatFits(textSize).height))
        
//        let chislitel = size.height > size.width ? size.height : size.width
        
        var h = CGFloat(size.height)
        let w = CGFloat(size.width)
        if w > self.frame.width, self.frame.width > 0 {
            h = h + (w / self.frame.width) * label.font.pointSize
        }
        
        let numberOfLine: Int = Int(h) / Int(label.font.pointSize)
        
        return numberOfLine
    }
}

extension UIFont {
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size
    }
}
