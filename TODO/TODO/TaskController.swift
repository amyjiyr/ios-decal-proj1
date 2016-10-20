//
//  TaskController.swift
//  TODO
//
//  Created by Amy Ji on 10/18/16.
//  Copyright © 2016 Amy Ji. All rights reserved.
//

import UIKit

var todolist: [[String]] = []

protocol todoDelegate {
    func newTodoCreated(controller:TaskController)
}

class TaskController: UIViewController, UITextFieldDelegate {
   
    var delegate: todoDelegate? = nil
    
    @IBOutlet var TaskTitle: UITextField!
    
    @IBOutlet var TaskContent: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TaskTitle.delegate = self
        self.TaskContent.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneEditing(_ sender: AnyObject) {
        if delegate != nil {
            if TaskTitle != nil {
                if UserDefaults.standard.object(forKey: "task") != nil {
                    todolist = (UserDefaults.standard.object(forKey: "task") as! [[String]])
                }
                todolist.append([TaskTitle.text!, TaskContent.text!])
                TaskTitle.text = ""
                TaskContent.text = ""
                UserDefaults.standard.set(todolist, forKey: "task")
                delegate!.newTodoCreated(controller: self)
            }
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
