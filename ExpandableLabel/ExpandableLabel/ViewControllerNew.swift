//
//  ViewControllerNew.swift
//  ExpandableLabel
//
//  Created by user on 1/2/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewControllerNew: UITableViewController, ExpandableLabelDelegate{
//
//    var tableView: UITableView!
    
    let numberOfCells : NSInteger = 13
    var states : Array<Bool>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        setupTableView()
        
        states = [Bool](repeating: true, count: numberOfCells)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
//    func setupTableView() {
//        tableView = UITableView(frame: CGRect(x: 0, y: self.view.frame.origin.y + 20, width: self.view.frame.width, height: self.view.frame.height - 20))
//        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
//        tableView.bounces = false
//
//        self.view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableViewAutomaticDimension
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSource = preparedSources()[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.expLabel.delegate = self
        
        cell.expLabel.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: currentSource.textAlignment)
        
        cell.layoutIfNeeded()
        
        cell.expLabel.shouldCollapse = true
        cell.expLabel.textReplacementType = currentSource.textReplacementType
        cell.expLabel.numberOfLines = currentSource.numberOfLines
        cell.expLabel.collapsed = states[indexPath.row]
        cell.expLabel.text = currentSource.text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("qq")
    }
    
    func preparedSources() -> [(text: String, textReplacementType: ExpandableLabelNew.TextReplacementType, numberOfLines: Int, textAlignment: NSTextAlignment)] {
        return [(loremIpsumText(), .word, 3, .left),
                (textWithNewLinesInCollapsedLine(), .word, 2, .left),
                (textWithLongWordInCollapsedLine(), .character, 1, .left),
                (textWithVeryLongWords(), .character, 1, .left),
                (loremIpsumText(), .word, 4, .left),
                (loremIpsumText(), .character, 3, .left),
                (loremIpsumText(), .word, 2, .left),
                (loremIpsumText(), .character, 5, .left),
                (loremIpsumText(), .word, 3, .left),
                (loremIpsumText(), .character, 3, .left),
                (textWithShortWordsPerLine(), .character, 3, .left),
                (textEmojis(), .character, 3, .left),
                (textWithThreePoint(), .word, 2, .left)
        ]
    }
    
    
    func loremIpsumText() -> String {
        return "On third line our text need be collapsed because we have ordinary text, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithNewLinesInCollapsedLine() -> String {
        return "When u had new line specialChars \n More not appeared eirmod\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n tempor invidunt ut\n\n\n\n labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithLongWordInCollapsedLine() -> String {
        return "When u had long word which not entered in one line More not appeared FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithVeryLongWords() -> String {
        return "FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR FooBaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaR Will show first line and will increase touch area for more voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    }
    
    func textWithShortWordsPerLine() -> String {
        return "A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN"
    }
    
    func textEmojis() -> String {
        return "😂😄😃😊😍😗😜😅😓☺️😶🤦😒😁😟😵🙁🤔🤓☹️🙄😑😫😱🙂😧🤵😶👥👩‍❤️‍👩💖👨‍❤️‍💋‍👨💏👩‍👩‍👦‍👦👦👀👨‍👩‍👧‍👦👩‍❤️‍👩🗨🕴👩‍❤️‍💋‍👩👧☹️😠😤😆💚🙄🤒💋😿👄"
    }
    
    func textWithThreePoint() -> String {
        return "Text with ... and it continue after it. I feel interirsting, what will matter."
    }
    
    //
    // MARK: ExpandableLabel Delegate
    //
    
    func willExpandLabel(_ label: ExpandableLabelNew) {
        tableView.beginUpdates()
    }
    
    func didExpandLabel(_ label: ExpandableLabelNew) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
    
    func willCollapseLabel(_ label: ExpandableLabelNew) {
        tableView.beginUpdates()
    }
    
    func didCollapseLabel(_ label: ExpandableLabelNew) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
}

extension String {
    
    func specialPriceAttributedStringWith(_ color: UIColor) -> NSMutableAttributedString {
        let attributes = [NSAttributedStringKey.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int),
                          .foregroundColor: color, .font: fontForPrice()]
        return NSMutableAttributedString(attributedString: NSAttributedString(string: self, attributes: attributes))
    }
    
    func priceAttributedStringWith(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedStringKey.foregroundColor: color, .font: fontForPrice()]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func priceAttributedString(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedStringKey.foregroundColor: color]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    fileprivate func fontForPrice() -> UIFont {
        return UIFont(name: "Helvetica-Neue", size: 13) ?? UIFont()
    }
}
