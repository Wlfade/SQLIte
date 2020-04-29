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
//        SQLiteTool.shareInstance.creatTable()
        
        //插入数据
//        let stu = StudentModel(name: "李四", age: 19, score: 66)
//        stu.insertStudent()
//
//        //删除数据
//        StudentModel .deleteStudent(name: "李四")
//
//        StudentModel.updateStudent(newStu: stu)
        
//        stu.bindInsert()
        
        
        print("点击")
        let beginTime = CFAbsoluteTimeGetCurrent()
        
        let stu = StudentModel(name: "张三", age: 19, score: 22)
//        for i in 0..<5000 {
//            stu.age = i
//            stu.bindInsert()
//        }
        
        stu.fengjieBindInsert()
        
        let endTime = CFAbsoluteTimeGetCurrent()
        
        print(endTime - beginTime)
        
        
    }
}

