//
//  LeaderBoardCell.swift
//  zhazam
//
//  Created by Abai Kalikov on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

final class LeaderBoardCell: UITableViewCell {
    
    @IBOutlet private var playerNickName: UILabel!
    @IBOutlet private var placeStatus: UILabel!
    @IBOutlet private var resultCount: UILabel!
    @IBOutlet private var measurementType: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureItems(model: LeaderBoardViewModel) {
        self.playerNickName.text = model.playerName
        self.placeStatus.text = model.placeTitle
        self.resultCount.text = model.resultCount
        self.measurementType.text = model.measurement
    }
}
