//
//  Question.swift
//  PDD
//
//  Created by Алексей Крестинин on 13.03.17.
//  Copyright © 2017 Alexey Krestinin. All rights reserved.
//

import UIKit


/*
 {"biletNumber":1,"questNumber":1,"quest":"Какие транспортные средства по Правилам относятся к маршрутным транспортным средствам?","v":["Все автобусы.","Автобусы, троллейбусы и трамваи, предназначенные для перевозки людей и движущиеся по установленному маршруту с обозначенными местами остановок.","Любые транспортные средства, перевозящие пассажиров.",null,null],"otvet":2,"comments":"Критерием отнесения ТС к маршрутным - является наличие установленного маршрута с обозначенными местами остановок. К таковым Правила относят автобусы, троллейбусы и трамваи \u003ca class\u003d\u0027btn btn-primary btn-sm\u0027 data-punkt\u003d\u0027/pdd/pdd1.2.html\u0027\u003eп. 1.2\u003c/a\u003e. Автомобили-такси к маршрутным ТС не относятся."}
 
 */
struct Question {
    let title:String // заголовок
    let v:[String]  // Варианты ответов
    let biletNumber:Int
    let questNumber:Int // номер вопроса
    let comments:String
    
    private let imageName:String
    private let otvet:Int // номер правильного ответа
    
    var image:UIImage? {
        return UIImage(named:imageName)
    }
    
    //  ЗАГРУЗКА КАРТИНКИ ИЗ ИНТЕРНЕТА
//    let  urlString = "http://mypressyImage.jpg"
//    let request = NSURLRequest(URL: NSURL(string: urlString)!)
//    
//    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
//    
//    guard data != nil else {
//    
//    return
//    }
//    
//    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//    self.myImageView.image = UIImage(data: data!)
//    })
//    
//    }.resume()


    init? (json:[String:Any]) {
        
        guard let title = json["quest"] as? String, // Заголовок равен вопросу
            let imageName = json["realUrl"] as? String, // картинка?
            let correctAnswer = json["otvet"] as? Int, // интовое значение ответа
            let answers = json["v"] as? [String], // мы ожидаем увидеть массив строк по ключу answers
            let biletNumber = json["biletNumber"] as? Int, // номер билета
            let questNumber = json["questNumber"] as? Int,
            let comments = json["comments"] as? String
            //            answers.contains(correctAnswer) // убедимся, что среди предложенных вариантов ответов есть правильный
            else {
                return nil
        }
        
        self .title = title
        self.imageName = imageName
        self.otvet = correctAnswer
        self.v = answers
        self.biletNumber = biletNumber
        self.questNumber = questNumber
        self.comments = comments
        
    }
    // метод для проверки правильного ответа
    
    func answerIsCorrect(answer:String) -> Bool {
        for (_,_) in v.enumerated() {
            if v[otvet-1] == answer {
                return true
            }
            
        }
        
        return false
    }
    
    
    
}

