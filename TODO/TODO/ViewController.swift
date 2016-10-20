//
//  ViewController.swift
//  TODO
//
//  Created by Amy Ji on 10/18/16.
//  Copyright © 2016 Amy Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, todoDelegate, statDelegate, UITableViewDataSource, UITableViewDelegate {
    // an array of cells, each cell is also a size 2 list containing the subtitle and the content
    var todolist: [[String]] = []
    var complete: Int = 0
    
    @IBOutlet var amysTableView: UITableView!

    // basic viewController initializations
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UserDefaults.standard.object(forKey: "task") != nil {
            todolist = (UserDefaults.standard.object(forKey: "task") as! [[String]])
        }
        if UserDefaults.standard.object(forKey: "numcomplete") != nil {
            complete = (UserDefaults.standard.object(forKey: "numcomplete") as! Int)
        }
        self.amysTableView.delegate = self
        self.amysTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // handling input from TaskController
    func newTodoCreated(controller:TaskController) {
        controller.navigationController?.popViewController(animated: true)
        if UserDefaults.standard.object(forKey: "task") != nil {
            todolist = (UserDefaults.standard.object(forKey: "task") as! [[String]])
        }
    }
    
    // giving input to StatsController
    func doneStats(controller:StatsController) {
        controller.navigationController?.popViewController(animated: true)
    }
    
    // loading the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UserDefaults.standard.object(forKey: "task") != nil {
            todolist = (UserDefaults.standard.object(forKey: "task") as! [[String]])
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "todotask", for: indexPath) as! AmysTableViewCell
        let cell_subtitle = todolist[indexPath.row][0]
        let cell_content = todolist[indexPath.row][1]
        cell.cellTitle.text = cell_subtitle
        cell.cellContent.text = cell_content
        return cell
    }
    
    
    // function to delete a cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        if editingStyle == .delete {
            if (cell?.accessoryType == .checkmark) {
                complete = complete - 1
                cell?.accessoryType = .none
                UserDefaults.standard.set(complete, forKey: "numcomplete")
            }
            todolist.remove(at: indexPath.row)
            UserDefaults.standard.set(todolist, forKey: "task")
            tableView.reloadData()
        }
    }
    
    // function to mark a task as complete
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AmysTableViewCell
        if (cell.accessoryType != .checkmark) {
            cell.accessoryType = .checkmark
            complete = complete + 1
            UserDefaults.standard.set(complete, forKey: "numcomplete")
            UserDefaults.standard.set(todolist, forKey: "task")
        } else {
            cell.accessoryType = .none
            complete = complete - 1
            UserDefaults.standard.set(complete, forKey: "numcomplete")
            UserDefaults.standard.set(todolist, forKey: "task")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        amysTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if UserDefaults.standard.object(forKey: "task") != nil {
            todolist = (UserDefaults.standard.object(forKey: "task") as! [[String]])
        }
        if segue.identifier == "todoConnect" {
            let taskManager: TaskController = segue.destination as! TaskController
            taskManager.delegate = self
        }
        else if segue.identifier == "statsConnect" {
            // im the one sending data now
            let stcontroller : StatsController = segue.destination as! StatsController
            stcontroller.numberText = String(complete)
            stcontroller.delegate = self
        }
    }

}

