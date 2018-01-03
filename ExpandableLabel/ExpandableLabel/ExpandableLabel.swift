//
//  ExpandableLabel.swift
//  ExpandableLabel
//
//  Created by user on 12/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

protocol LabelDelegate {
    func beginUpdateTableView()
    func endUpdateTableView(label: ExpandableLabel)
}

enum LabelState {
    case expanded
    case collapsed
}

class ExpandableLabel: UIView {
    
    var delegate: LabelDelegate?
    
//    var expandedBottomConstraint = NSLayoutConstraint()
//    var collapsedBottomConstraint = NSLayoutConstraint()
    
    var state: LabelState = .collapsed {
        didSet {
            label.numberOfLines = 4
            switch state {
            case .expanded:
                button.isHidden = false
            case .collapsed:
                button.isHidden = true
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
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    var labelWidth: CGFloat = 0
    
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
        let collapsedBottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, collapsedBottomConstraint, leftConstraint, rightConstraint])
        
//        expandedBottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let heightButtonConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        let widthButtonConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let rightButtonConstraint = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomButtonConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([heightButtonConstraint, widthButtonConstraint, rightButtonConstraint, bottomButtonConstraint])
    }
    
    func addActions() {
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    @objc func buttonTap() {
        switch state {
        case .expanded:
            delegate?.beginUpdateTableView()
            button.isHidden = true
            label.numberOfLines = 0
            delegate?.endUpdateTableView(label: self)
        case .collapsed:
            break
        }
    }
    
    func setState() {
        let numberOfLines = text.height(withConstrainedWidth: self.labelWidth, font: label.font) / (label.font.pointSize * 1.2)
        self.state = numberOfLines > 4 ? .expanded : .collapsed
    }

    
    var text: String = "" {
        didSet{
            label.text = text
            setState()
        }
    }
}

//extension UIFont {
//    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
//        return NSString(string: string).boundingRect(
//            with: CGSize(width: width, height: .greatestFiniteMagnitude),
//            options: .usesLineFragmentOrigin,
//            attributes: [.font: self],
//            context: nil).size
//    }
//}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
//    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
//        
//        return ceil(boundingBox.width)
//    }
}
