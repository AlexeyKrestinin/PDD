//
//  ResultViewController.swift
//  PDD
//
//  Created by Алексей Крестинин on 16.03.17.
//  Copyright © 2017 Alexey Krestinin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
     var score = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var text = ""
        switch score {
        case 1: text = "Ваш результат \(score) правильный ответ"
        case 2...4: text = "Ваш результат \(score) правильных ответа"
        case 5...20: text = "Ваш результат \(score) правильных ответов"
        default: text = "Невозможно"
        }
        
        resultLabel.text = "\(text)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
