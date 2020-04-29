//
//  ViewController.swift
//  FMDB-Pra
//
//  Created by 王玲峰 on 4/29/20.
//  Copyright © 2020 王玲峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        SQLiteTool.shareInstance.insertRecord()
         SQLiteTool.shareInstance.queryAll()
    }


}

