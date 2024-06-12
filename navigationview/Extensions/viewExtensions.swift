//
//  viewExtensions.swift
//  vcb_client
//
//  Created by Billy Cole on 7/19/23.
//

import UIKit


extension SensorViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var learnModeCell = tableView.dequeueReusableCell(withIdentifier: id)
        
        if(learnModeCell == nil){
            learnModeCell = UITableViewCell(style: .default, reuseIdentifier: id)
           
        }
        
       // cell?.textLabel?.text = "Title Information."
        //cell?.detailTextLabel?.text = "Detail Information here."
        let rowNum = indexPath.row
       
       
        
        learnModeCell?.textLabel?.text = weeks[rowNum]
        if(rowNum == 1)
        {
            learnModeCell?.textLabel?.text = String(7)
            learnModeCell?.detailTextLabel?.text = "Detail Information here."
        }
        
        return learnModeCell!
    }
    
    
    
    
    
}

/*
 else {
    let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
     let view = UIView(frame: rect)
     view.backgroundColor = UIColor.brown
     cell?.backgroundView = view
 }
 */
