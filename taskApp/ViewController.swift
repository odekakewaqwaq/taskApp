//
//  ViewController.swift
//  taskApp
//
//  Created by 永井 伸枝 on 2016/04/19.
//  Copyright © 2016年 nobue.nagai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView : UITableView, numberOfRowsInsSection section:Int) -> Int{
        return 0
    }
    
    func tableView(tableView : UITableView, didSelectRowAtIndexPath indexpPath : NSIndexPath){
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }


}

