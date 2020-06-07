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
                                                 action: #selector(didGameTypeButtonTap))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        return rightBarButtonItem
    }()
    
    private let provider = LeaderBoardProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setupProvider()
    }
    
    @objc func didGameTypeButtonTap() {
        manageButton()
        guard let gameType = provider.configuration?.setGameType() else { return }
        provider.setLeaderBoards(by: gameType)
    }
    
    private func setupProvider() {
        provider.delegate = self
        provider.setConfigurationData()
        provider.setLeaderBoards(by: .classic)
        gameTypeButton.title = provider.configuration?.currentValue
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeaderBoardCell.self, forCellReuseIdentifier: identifier)
    }
    
    private func manageButton() {
        provider.configuration?.next()
        gameTypeButton.title = provider.configuration?.currentValue
    }
}

extension LeaderBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.leaderBoards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LeaderBoardCell
        let leaderBoardModel = provider.leaderBoards[indexPath.row]
        cell.configureItems(model: leaderBoardModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableViewRowHeight
    }
}

extension LeaderBoardViewController: LeaderBoardProviderDelegate {
    func didUpdate() {
        tableView.reloadData()
    }
}
