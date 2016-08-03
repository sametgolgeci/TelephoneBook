//
//  EditViewController.swift
//  TelephoneBook
//
//  Created by Samet Gölgeci on 29/07/16.
//  Copyright © 2016 SametGolgeci. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {

    @IBOutlet weak var labelNo: UILabel!
    @IBOutlet weak var labelTry: UILabel!
    
    var tmpName :String = ""
    var tmpNo : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTry.text = tmpName
        labelNo.text = tmpNo
    }
    
    
    
    
}
