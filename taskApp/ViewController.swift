//
//  ViewController.swift
//  taskApp
//
//  Created by 永井 伸枝 on 2016/04/19.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var taskArray = try!Realm().objects(Task).sorted("date", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSourceプロトコルのメソッド
    //セルの数を返すメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    //各セルの内容を返すメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        let category = task.category
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let caption:String = category + " - " + formatter.stringFromDate(task.date)
        cell.detailTextLabel?.text = caption
        
        return cell
    }
    
    // MARK: UITableViewDelegateプロトコルのメソッド
    //各セルを選択した時に実行されるメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("cellSegue", sender: nil)
    }
    
    
    //セルが削除可能なことを伝えるメソッド
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexpath:NSIndexPath)->UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }

    //Deleteボタンが押された時に呼ばれるメソッド
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            let task = taskArray[indexPath.row]
            
            for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
                if notification.userInfo!["id"] as! Int == task.id{
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                    break
                }
            }
            
            try! realm.write{
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let inputViewController:InputViewController = segue.destinationViewController as! InputViewController
        
        if segue.identifier == "cellSegue"{
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        }else{
            let task = Task()
            task.date = NSDate()
            
            if taskArray.count != 0{
                task.id = self.taskArray.max("id")! + 1
            }
            inputViewController.task = task
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("category = ")
        taskArray = realm.objects(Task).filter("category BEGINSWITH '\(searchText)'")
        tableView.reloadData()
    }
        //let searchWord = searchBar.text
        //let categorizedTask = realm.objects(Task).filter("category = '\(searchWord)'"
    
}

