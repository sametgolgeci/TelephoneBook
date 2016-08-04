//
//  StartViewController.swift
//  TelephoneBook
//
//  Created by Samet Gölgeci on 04/08/16.
//  Copyright © 2016 SametGolgeci. All rights reserved.
//

import UIKit

class StartViewController: UIViewController,HolderViewDelegate {
    
    var holderView = HolderView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
        NSTimer.scheduledTimerWithTimeInterval(4.10, target: self, selector: #selector(HolderView.nextPage),
                                               userInfo: nil, repeats: false)
    }
    
    func nextPage(){
        self.performSegueWithIdentifier("mainSegue",sender: NSIndexPath.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100.0
        holderView.frame = CGRect(x: view.bounds.width / 2 - boxSize / 2,
                                  y: view.bounds.height / 2 - boxSize / 2,
                                  width: boxSize,
                                  height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        view.addSubview(holderView)
        holderView.addOval()
    }
    
    func animateLabel() {
        
    }
    
    func addButton() {
        let button = UIButton()
        button.frame = CGRectMake(0.0, 0.0, view.bounds.width, view.bounds.height)
        button.addTarget(self, action: #selector(StartViewController.buttonPressed(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!) {
        view.backgroundColor = Colors.white
        view.subviews.map({ $0.removeFromSuperview() })
        holderView = HolderView(frame: CGRectZero)
        addHolderView()
    }
}
