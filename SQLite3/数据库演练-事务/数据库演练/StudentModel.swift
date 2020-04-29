//
//  StudentModel.swift
//  数据库演练
//
//  Created by 王玲峰 on 4/28/20.
//  Copyright © 2020 王玲峰. All rights reserved.
//

import UIKit

class StudentModel: NSObject {
    
    /// 定义属性
    @objc var name : String = ""
    @objc var age : NSInteger = 0
    @objc var score : Float = 0.0
    

    ///初始化
    override init() {
        super.init()
    }
    init(name:String,age:Int,score:Float){
        super.init()
        self.name = name
        self.age = age
        self.score = score
    }
    init(dic:[String:AnyObject]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return  dictionaryWithValues(forKeys: ["name","age","score"]).description
    }
    
    //MARK:- DML
    
    ///更新数据
    class func update(sql:String)-> (Bool){
        return SQLiteTool.shareInstance.squliteExe(sql: sql)
    }
    
    ///绑定
    func fengjieBindInsert() -> () {
        let sql = "insert into t_stu(name,age,score) values (?,?,?)"
        let db = SQLiteTool.shareInstance.db
        var stmt : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("预处理失败")
            return
        }
        
        //手动开启事务
        SQLiteTool.shareInstance.beginTransaction()
        
        for _ in 0..<10000 {
            //2.绑定参数
            sqlite3_bind_int(stmt, 2, 20)
            sqlite3_bind_double(stmt, 3, 99.9)
        
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            sqlite3_bind_text(stmt, 1, "zhangsan", -1, SQLITE_TRANSIENT)
             
            //3.执行sql语句，准备语句
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("执行成功")
            }
             
            //4.重置语句
            sqlite3_reset(stmt)
        }
        
        SQLiteTool.shareInstance.commitTransaction()

        //5.释放准备语句
        sqlite3_finalize(stmt)
    }
    
    /// 绑定插入
    func bindInsert() -> () {
        let sql = "insert into t_stu(name,age,score) values (?,?,?)"
        //根据sql字符串，创建、准备语句
        //参数1：一个已经打开的数据库
        //参数2：sql 字符串"123432334"
        //参数3：取出字符串的长度 "2" -1: 代表自动计算
        //参数4：预处理语句
        //参数5：根据参数3的长度，取出参数2的值之后，剩余的参数
        
        let db = SQLiteTool.shareInstance.db
        var stmt : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("预处理失败")
            return
        }
        
        //2.绑定参数
        //参数1：准备语句
        //参数2：绑定值得索引 索引 从1 开始
        //参数3：需要绑定的值
        sqlite3_bind_int(stmt, 2, 20)
        sqlite3_bind_double(stmt, 3, 99.9)
        
        //绑定文本（姓名）
        //参数1：准备语句
        //参数2：绑定索引 1
        //参数3：绑定的值 “123”
        //参数4：值取出长度 -1 ，取出所有
        //参数5：值得处理
        //SQLITE_STATIC : 认为参数是一个常量，不会被释放，处理方案：不做任何的引用
        //SQLITE_TRANSIENT: 会对参数，进行一个引用
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        sqlite3_bind_text(stmt, 1, "zhangsan", -1, SQLITE_TRANSIENT)
        
        //3.执行sql语句，准备语句
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("执行成功")
        }
        
        //4.重置语句
        sqlite3_reset(stmt)
        
        //5.释放准备语句
        sqlite3_finalize(stmt)
    }
    
    /// 插入数据
    func insertStudent() -> () {
        let sql = "insert into t_stu(name,age,score) values ('\(name)',\(age),\(score))"
        if  SQLiteTool.shareInstance.squliteExe(sql: sql){
            print("插入成功")
        }
    }
    
    
    /// 删除
    /// - Parameter name: 根据数据的名字删除数据
    class func deleteStudent(name:String) -> () {
        let sql = "delete from t_stu where name = '\(name)'"
        if  SQLiteTool.shareInstance.squliteExe(sql: sql){
            print("删除成功")
        }
    }

    
    /// 更新
    /// - Parameter newStu: 根据模型的name 修改数据
    class func updateStudent(newStu:StudentModel) -> () {
        let sql = "update t_stu set name = '\(newStu.name)', age = \(newStu.age), score = \(newStu.score) where name = '\(newStu.name)'"
        print(sql)
        if  SQLiteTool.shareInstance.squliteExe(sql: sql){
            print("修改成功")
        }else{
            print("修改失败")
        }
    }

}
