//
//  LeaderBoardViewController.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class LeaderBoardViewController: UIViewController, Reusable {
    
    private enum Constants {
        static let tableViewRowHeight: CGFloat = 65
    }
    
    @IBOutlet private var tableView: UITableView!
    
    lazy var gameTypeButton: UIBarButtonItem = {
        let rightBarButtonItem = UIBarButtonItem(title: "Classic",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(didTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        return rightBarButtonItem
    }()
    
    private let storage: LeaderBoardStorage
    var leaderBoards = [LeaderBoardRowModel]()
    
    init(storage: LeaderBoardStorage) {
        self.storage = storage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
        configureTableView()
    }
    
    @objc func didTapped() {
        manageButton()
        guard let gameTypeIndex = storage.configuration?.index else { return }
        leaderBoards = storage.leaderBoards[gameTypeIndex]
        tableView.reloadData()
    }
    
    private func setupInitialState() {
        leaderBoards = storage.leaderBoards.first!
        gameTypeButton.title = storage.configuration?.currentValue
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: identifier)
    }
    
    private func manageButton() {
        storage.configuration?.next()
        gameTypeButton.title = storage.configuration?.currentValue
    }
}

extension LeaderBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderBoards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LeaderBoardCell
        let leaderBoardModel = leaderBoards[indexPath.row]
        cell.configureItems(model: leaderBoardModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
}
