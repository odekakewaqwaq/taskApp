//
//  Task.swift
//  taskApp
//
//  Created by 永井 伸枝 on 2016/04/23.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//


import RealmSwift

class Task: Object{
    dynamic var id = 0
    
    dynamic var title = ""
    
    dynamic var contents = ""

    dynamic var date = NSDate()
    
    dynamic var category = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }
}