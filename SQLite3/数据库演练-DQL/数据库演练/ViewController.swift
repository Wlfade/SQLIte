//
//  ViewController.swift
//  数据库演练
//
//  Created by 王玲峰 on 4/26/20.
//  Copyright © 2020 王玲峰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        SQLiteTool.shareInstance.beginTransaction()
        
//        //张 -10
//        //李 +10
//        let result1 = StudentModel.update(sql: "update t_stu set money = money - 10 where name = 'zhang'")
//        let result2 = StudentModel.update(sql: "update t_stu set money = money + 10 where name = 'li'")
//
//        if result1 && result2 {
//            SQLiteTool.shareInstance.commitTransaction()
//        }else{
//            SQLiteTool.shareInstance.rallbackTransaction()
//        }
        
//         queryAll
//        StudentModel.queryAll()
        
        StudentModel.bingdQueryAll()
        
    }
}

