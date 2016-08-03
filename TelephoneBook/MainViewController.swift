//
//  MainViewController.swift
//  TelephoneBook
//
//  Created by Samet Gölgeci on 21/07/16.
//  Copyright © 2016 SametGolgeci. All rights reserved.
//

import UIKit
import Firebase

let myRef = FIRDatabase.database().reference().child("Phonebook").child("List")

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        items = [NSDictionary]()
        loadDataFromFirebase()
    }
    
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadDataFromFirebase(){
        myRef.observeEventType(.Value) { (snap : FIRDataSnapshot) in
            var tempItems = [NSDictionary]()
            
            for item in snap.children {
                let child = item as! FIRDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            self.items = tempItems
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let myCell: String = "myCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(myCell)
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: myCell)
        }
        
        let tmp = items[indexPath.row]
        
        cell?.textLabel?.text = String(tmp["Name"] as! String)
        cell?.detailTextLabel?.text = String(tmp["Phone"] as! String)
        return cell!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let myHeader = UIView(frame: CGRectMake(10, 0,  tableView.frame.width, tableView.frame.height))
        myHeader.backgroundColor = UIColor.lightGrayColor()
        return myHeader
    }
     
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 1
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        let myFooter = UIView(frame: CGRectMake(0, 0,  tableView.frame.width, tableView.frame.height))
        myFooter.backgroundColor = UIColor.lightGrayColor()
        return myFooter
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 1
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let tmpDic = items[indexPath.row]
            let tmpString = String(tmpDic["Name"] as! String)
            let tmpRef = myRef.child(tmpString)
            tmpRef.removeValue()
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if ( segue.identifier == "editPersonSegue"){
            let editVC = segue.destinationViewController as! EditViewController
            let person = items[(tableView.indexPathForSelectedRow?.row)!]
            editVC.tmpName = String(person["Name"] as! String)
            editVC.tmpNo = String(person["Phone"] as! String)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("editPersonSegue", sender: indexPath)
    }
    
    

    
}
