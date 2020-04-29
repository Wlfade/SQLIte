//
//  SQLiteTool.swift
//  FMDB-Pra
//
//  Created by 王玲峰 on 4/29/20.
//  Copyright © 2020 王玲峰. All rights reserved.
//

import UIKit

class SQLiteTool: NSObject {
    //单例
    static let shareInstance = SQLiteTool()
    var db : FMDatabase?
    
    override init() {
        super.init()
        let path = "/Users/wanglingfeng/Desktop/database/demo.sqlite"
        //打开，创建一个数据库
        db = FMDatabase(path: path)
        
        if db!.open() {
            print("数据库打开成功")
            creatTable()
        }else{
            print("数据库打开失败")
        }
        
    }
    
    
    //创建
    func creatTable() -> () {
        let sql = "create table t_stu(id integer primary key autoincrement,name text not null, age integer,score real default 60,money real)"
        
        let result = db?.executeUpdate(sql, withArgumentsIn: [])
        if result! {
            print("yes")
        }else{
            print("NO")
        }
    }
    
    //删除
    func dropTable() -> () {
        let sql = "drop table if exists t_stu"
        
        let result = db?.executeUpdate(sql, withArgumentsIn: [])
        if result! {
            print("yes")
        }else{
            print("NO")
        }
    }
    
    //插入数据
    func insertRecord() -> () {
        let sql = "insert into t_stu(name,age,score) values ('hah',15,99)"

        let result = db?.executeUpdate(sql, withArgumentsIn: [])
        if result! {
            print("yes")
        }else{
            print("NO")
        }
    }


    //查询数据
    func queryAll() -> () {
        let sql = "select * from t_stu"

        guard let result = db?.executeQuery(sql, withArgumentsIn: [])
            else{
                return
        }
        while result.next() {
            let name =  result.string(forColumn: "name")
            let age =  result.int(forColumn: "age")
            let score =  result.double(forColumn: "score")
            print(name as Any,age,score)

        }
    }

}
