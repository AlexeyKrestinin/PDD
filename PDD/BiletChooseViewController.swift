//
//  BiletChooseViewController.swift
//  PDD
//
//  Created by Алексей Крестинин on 16.03.17.
//  Copyright © 2017 Alexey Krestinin. All rights reserved.
//

import UIKit

class BiletChooseViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    var bilets = ["b1","b2","b3","b4","b5","b6","b7","b8","b9","b10"]
    var biletNums = [1,2,3,4,5,6,7,8,9,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? PddViewController,
            let biletToShow = sender as? String {
            destVC.biletNum = biletToShow
            
        }
    }
    
    
}

extension BiletChooseViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let biletNum = bilets[indexPath.row]
        // запустим переход на новый экран
        // название перехода SHow Result
        performSegue(withIdentifier: "Show Bilet", sender: String(biletNum))
        
        
        return
    }
    
    
    
}


extension BiletChooseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bilets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
       
        
        
        cell.textLabel?.text = "Билет номер: \(biletNums[indexPath.row])"
        
        return cell
        
    }
}
