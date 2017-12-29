
//
//  ViewController.swift
//  ExpandableLabel
//
//  Created by user on 12/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var arrayModels: [Model] = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        let array = ["aasdghjasgdas\naasdghjasgdas\ndfdfjaasdghjasgdas\naasdghjasgdas\n", "ahj\n\n\n\n\n\n\n\n\n\n\n\nsdhj\nasdh\njagh\njsd\n", "asd asdasd asd ", "asdaghsdasfgdafsdasfghdadasfghdafghdafghdafghdadafghsdasdafghsadfghdsafghdfgafghsdasdasdadafghsdafghdsasdasfghdagsdfaghfsdafghsd", "asdasdas asdadasd  asdasda\nasdasd asdasd asd"]
        for i in array {
            let model = Model()
            model.string = i
            arrayModels.append(model)
        }
        
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: self.view.frame.origin.y + 20, width: self.view.frame.width, height: self.view.frame.height - 20))
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.bounces = false

        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.expandableLabel.text = arrayModels[indexPath.row].string
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayModels.count
    }
    
}

class Model {
    var string: String = ""
}

class Cell: UITableViewCell {
    
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
        expandableLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        expandableLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        expandableLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
