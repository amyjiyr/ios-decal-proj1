//
//  StatsController.swift
//  TODO
//
//  Created by Amy Ji on 10/19/16.
//  Copyright © 2016 Amy Ji. All rights reserved.
//

import UIKit

protocol statDelegate {
    func doneStats(controller:StatsController)
}

class StatsController: UIViewController {
    
    var delegate: statDelegate? = nil

    @IBOutlet var completeTitle: UILabel!
    
    @IBOutlet var numberCompleted: UILabel!
    
    var numberText = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberCompleted.text = numberText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goBack(_ sender: AnyObject) {
        if delegate != nil {
            delegate!.doneStats(controller: self)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
