//
//  SQLiteTool.swift
//  数据库演练
//
//  Created by 王玲峰 on 4/27/20.
//  Copyright © 2020 王玲峰. All rights reserved.
//

import UIKit

class SQLiteTool: NSObject {
    //单例
    static let shareInstance = SQLiteTool()
    
    var db : OpaquePointer? = nil
    ///初始化
    override init() {
        super.init()
        //1.创建一个数据库
        //打开一个指定的数据库，如果数据库不存在，则创建 存在 则打开，而且赋值给参数2
        //参数1：数据库路径
        //参数2：一个已经打开的数据库（如果后期要执行sql语言，都需要借助这个对象）
        //关于sqlite 数据库文件名的后缀没有要求 abc,123
        // sqlite db db3
        let path = "/Users/wanglingfeng/Desktop/database/demo.sqlite"
        
        if sqlite3_open(path, &db) == SQLITE_OK{
            print("执行成功")
        }else{
            print("执行失败")
        }
    }
    
    //创建表
    func creatTable() -> (){
        let sql = "create table t_stu(id integer primary key autoincrement,name text not null, age integer,score real default 60)"
        
        if self.squliteExe(sql: sql) == true {
            print("do smoting")
        }

        
    }
    
    
    /// 删除表
    func dropTable() -> () {
        let sql = "drop table if exists t_stu"
        if self.squliteExe(sql: sql) == true {
            print("do smoting")
        }

    }
    
    func squliteExe(sql:String) -> (Bool) {
        
        //参数1：已经打开的数据库
        //参数2：需要执行的sql字符串
        //数据3：执行回调
        //参数4：参数3 参数1
        //参数5：错误信息
        return sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK
//       if sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK {
//            print("成功")
//            return true
//        }else{
//            print("失败")
//            return false
//        }
    }
    
    func beginTransaction() ->() {
        let sql = "begin transaction"
        squliteExe(sql: sql)
    }
    func commitTransaction() ->() {
        let sql = "commit transaction"
        squliteExe(sql: sql)
    }
    
    
    
        //优化方案： 如果s使用sqlite3_exec 或者 sqlite3_step()来执行sql语句，会自动开启一个事务，然后自动提交事务
    //结局方案：只需要手动开启事务，手动提交事务，这时候，函数内部，就不会自动开启和gt提交事务
}
