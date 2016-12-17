//
//  ViewController.swift
//  supermarket
//
//  Created by apple on 2016/10/4.
//  Copyright © 2016年 zoujiahong. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    var cellid = "cellId"
    var shangpins = [shangpin]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "TableViewCell",bundle:nil), forCellReuseIdentifier: cellid)
        self.navigationItem.title = "客户订单"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.separatorColor = UIColor.lightGrayColor()
        fetchgoods()
    }
    var array :[String] = []
    func fetchgoods(){
        FIRDatabase.database().reference().child("order").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let array = snapshot.key
            self.array.append(array)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let shangping = shangpin()
                shangping.setValuesForKeysWithDictionary(dictionary)
                self.shangpins.append(shangping)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            }, withCancelBlock: nil)
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shangpins.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :TableViewCell = tableView.dequeueReusableCellWithIdentifier(cellid) as! TableViewCell
        let shangpin = shangpins[indexPath.row]
        if let fromid = shangpin.fromid {
            FIRDatabase.database().reference().child("users").child(fromid).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                if let Dictionary = snapshot.value as? [String:AnyObject]{
                    cell.namelabel.text = Dictionary["name"] as? String
                    let imageurl = Dictionary["profileimageurl"] as? String
                    cell.profileimageview.kf_setImageWithURL(NSURL(string: imageurl!)!)
                    cell.profileimageview.layer.cornerRadius = 12.5
                    cell.profileimageview.layer.masksToBounds = true
                }
                }, withCancelBlock: nil)
        }
        cell.addresslabel.text = shangpin.address
        cell.detaillabel.text = shangpin.discribe
        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let key = array[indexPath.row]
        FIRDatabase.database().reference().child("order").child(key).removeValueWithCompletionBlock { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            self.shangpins.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}

