//
//  AllPlayListTable.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/13.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import UIKit

class AllPlayListTable: UITableView , UITableViewDelegate,UITableViewDataSource{
    
    func setup(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
