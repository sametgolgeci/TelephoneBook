//
//  DetailViewController.swift
//  TelephoneBook
//
//  Created by Samet Gölgeci on 21/07/16.
//  Copyright © 2016 SametGolgeci. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    let listRef = FIRDatabase.database().reference().child("Phonebook").child("List")
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionSaveDetail(sender: AnyObject) {
        
        // childByAutoId() metodu ile özel bir id atılır.
        // childByAppendingPath() metodu ile eski metod üzerinde değişiklik olmaz yeni metot olarak kaydeder.(Farklı Kaydet) Ancak kodunuzda childByAutoId() metodu mevcut ise bu kodu kullanmaya gerek yoktur. Düzenle butonu için bu iki metot ta gereksiz hale gelir.
        // bütün girdileri aynı anda oluşturmak için as! AnyObject kontrolü uygulanır.
        
        listRef.childByAppendingPath(textFieldName.text!).setValue(["Name": textFieldName.text as! AnyObject, "Phone": textFieldPhoneNumber.text as! AnyObject])
        
        // AlertController
        let alertController = UIAlertController(title: "İşlem Tamamlandı!", message:
            "Kayıt İşlemi Başarıyla Gerçekleştirilmiştir!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default,handler: { action in self.navigationController?.popViewControllerAnimated(true) }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        //self.navigationController?.popViewControllerAnimated(true)
    }
}




