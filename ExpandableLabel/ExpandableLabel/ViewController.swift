
//
//  ViewController.swift
//  ExpandableLabel
//
//  Created by user on 12/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LabelDelegate {
    var cell: CellNew!
    var tableView: UITableView!
    var arrayModels: [Model] = [Model]()
    var arrayBolls: [Bool] = [Bool]()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        let array = ["aasdghj asgdas\naasd ghjasgdas\ndfdfja asdghja sgdas\naa sdghja sgdas\n", "ahj\n\n\n\n\n\n\n\n\n\n\n\nsdhj\nasdh\njagh\njsd\n", "asd asdasd asd ", "asdag hsdasfgdafs dasfg hdadasfgh dafghdafgh dafghdad afghsdas dafghsad fghdsa fghdf gafgh sdasd asdad afghs dafgh dsasdas fghda gsdf aghfs daf ghsd", "asdasdas asdadasd  asdasda\nasdasd asdasd asd"]
        arrayBolls = [false, false, false, false, false]
        for i in array {
            let model = Model()
            model.string = i
            arrayModels.append(model)
        }
        
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: self.view.frame.origin.y + 20, width: self.view.frame.width, height: self.view.frame.height - 20))
        tableView.register(CellNew.self, forCellReuseIdentifier: "CellNew")
        tableView.bounces = false
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        cell = tableView.dequeueReusableCell(withIdentifier: "CellNew") as! CellNew
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellNew") as! CellNew
//        cell.expandableLabel.label.numberOfLines = arrayBolls[indexPath.row] == true ? 0 : 4
//        cell.expandableLabel.state = arrayBolls[indexPath.row] == false ? .expanded : .collapsed
        cell.expandableLabel.text = arrayModels[indexPath.row].string
        cell.expandableLabel.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayModels.count
    }
    
    func beginUpdateTableView() {
        tableView.beginUpdates()
    }
    
    func endUpdateTableView(label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            arrayBolls[indexPath.row] = label.state == .expanded
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
    }
}

class Model {
    var string: String = ""
}

class CellNew: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeView()
    }
    
    private func makeView() {
        setupView()
        setupConstraints()
        cellSettings()
    }
    
    private func cellSettings() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.lightGray
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }

    var expandableLabel: ExpandableLabel = {
        let view = ExpandableLabel()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private func setupView() {
        self.addSubview(expandableLabel)
    }

    private func setupConstraints() {
        
        expandableLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        expandableLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        expandableLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        expandableLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

        expandableLabel.labelWidth = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeView()
    }
}

class Cell: UITableViewCell {
    
    @IBOutlet weak var expLabel: ExpandableLabelNew!
    override func prepareForReuse() {
        super.prepareForReuse()
        expLabel.collapsed = true
        expLabel.text = nil
    }
}
