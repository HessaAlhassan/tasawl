//
//  TableViewController.swift
//  تساؤل
//
//  Created by Hatan Dera on 07/06/1439 AH.
//  Copyright © 1439 Tsaul developers. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController ,  HomeModelDelegate {
    
    
    @IBOutlet var QTableView: UITableView!
    var homeModel = HomeModel()
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set self as the tableview's data source and delegate
        QTableView.delegate = self
        QTableView.dataSource = self
    
        
        // initiate callint the items download
        homeModel.getItems()
        homeModel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    //MARK: - UITableView Delegat Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = QTableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! TableViewCell
        cell.QTitle.text = questions[indexPath.row].title
        cell.QUsername.text = questions[indexPath.row].REmail
        cell.QDetails.text = questions[indexPath.row].Question_Details
        return cell;
    }
    
    
    func itemsDownloaded(questions: [Question]) {
        
        self.questions = questions
        QTableView.reloadData()
        
    }
    
    
  

}
