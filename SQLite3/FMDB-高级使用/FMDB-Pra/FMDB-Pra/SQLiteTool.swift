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
//    var db : FMDatabase?
    var dbQueue : FMDatabaseQueue? = FMDatabaseQueue(path: "/Users/wanglingfeng/Desktop/database/demo.sqlite")

    override init() {
        super.init()
    }
    
    
    //创建
    func creatTable() -> () {
        let sql = "create table t_stu(id integer primary key autoincrement,name text not null, age integer,score real default 60,money real)"
        
        
        dbQueue?.inDatabase { (db : FMDatabase!) in
            let result = db.executeUpdate(sql, withArgumentsIn: [])
            if result {
                print("yes")
            }else{
                print("NO")
            }
        }
    }
    
    //删除
    func dropTable() -> () {
        let sql = "drop table if exists t_stu"
        dbQueue?.inDatabase({ (db : FMDatabase!) in
            let result = db?.executeUpdate(sql, withArgumentsIn: [])
            if result! {
                print("yes")
            }else{
                print("NO")
            }
        })
    }
    
    //执行多条语句
    func executeStaments() -> () {
        let sql = "insert into t_stu(name,age,score) values ('hah',15,99);insert into t_stu(name,age,score) values ('kak',12,88)"

        dbQueue?.inDatabase({ (db : FMDatabase!) in
            let result = db?.executeUpdate(sql, withArgumentsIn: [])
            if result! {
                print("多条语句执行成功")
            }else{
                print("NO")
            }
        })

    }
    
    //插入数据
    func insertRecord() -> () {
        let sql = "insert into t_stu(name,age,score) values ('kaka ',9,9)"

        dbQueue?.inDatabase { (db : FMDatabase!) in
            let result = db.executeUpdate(sql, withArgumentsIn: [])
            if result {
                print("yes")
            }else{
                print("NO")
            }
        }
    }


    //查询数据
    func queryAll() -> () {
        let sql = "select * from t_stu"
        dbQueue?.inDatabase({ (db : FMDatabase!) in
            guard let result = db?.executeQuery(sql, withArgumentsIn: [])else{return}
            while result.next() {
                let name =  result.string(forColumn: "name")
                let age =  result.int(forColumn: "age")
                let score =  result.double(forColumn: "score")
                print(name as Any,age,score)
            }
        })
    }
    
    //事务
    func transaction() -> () {
        let sql1 = "insert into t_stu(name,age,score) values ('ka ',10,9)"
        let sql2 = "insert into t_stu(name,age,score) values ('aa ',10,29)"
        dbQueue?.inTransaction({ (db : FMDatabase, rollBack) in
            let result1 = db.executeUpdate(sql1, withArgumentsIn: [])
            let result2 = db.executeUpdate(sql2, withArgumentsIn: [])
            
            if result1 && result2{
                
            }else{
                rollBack.pointee = true
            }
        })

    }

}
