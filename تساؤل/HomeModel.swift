//
//  HomeModel.swift
//  تساؤل
//
//  Created by Hatan Dera on 07/06/1439 AH.
//  Copyright © 1439 Tsaul developers. All rights reserved.
//

import UIKit
protocol HomeModelDelegate {
    func itemsDownloaded(questions:[Question])
}
class HomeModel: NSObject {

    var delegate: HomeModelDelegate?
    
    func getItems(){
        
        // Hit the web service URL
        let serviceUrl = "http://tsawul.com/ts5.php"
        
        
        // Download the JSON data
        let url = URL(string: serviceUrl)
        if let url = url{
            
            //create URL sesstion
            let sesstion = URLSession(configuration: .default)
            let task = sesstion.dataTask(with: url, completionHandler: { (data, response, error) in
                if error == nil {
                    //succeeded
                    //call the parse Json function on the data
                    self.parseJson(data!)
                }
                else {
                    //error occured
                    
                }
            })
            //start the task
            task.resume()
        }
        
        
        // Nonify the view controler and pass the data back
        
    }
    
    func parseJson(_ data:Data){
        
        var queArray = [Question]()
        
        do{
            
            // Parse the data into json object
        let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [Any]
            
           //loop through each result in the jsonArray
            for jsonResult in jsonArray{
                
                //cast JSON results as Dictionary
                let jsonDict = jsonResult as! [String: String]
                
               //create new question and set its properities
                let Ques = Question(Question_ID: jsonDict["Question_ID"]!, Question_Details: jsonDict["Question_Details"]!, title: jsonDict["title"]!, Cat_ID: jsonDict["Cat_ID"]!, REmail: jsonDict["REmail"]!)
                
                //add it to the array
                queArray.append(Ques)
                print(jsonResult)
            }//end for
            
            // pass the question array back to delegate
            delegate?.itemsDownloaded(questions: queArray)
        }
        catch{
            print("There was an error")
        }
        
    }
    
    
}
