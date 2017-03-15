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
    let answers:[String]  // Варианты ответов
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
    
    // НОВАЯ ЗАГРУЗКА
//    let url = URL(string: image.url)
//    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//    imageView.image = UIImage(data: data!)


    init? (json:[String:Any]) {
        
        guard let title = json["quest"] as? String, // Заголовок равен вопросу
            let imageName = json["realUrl"] as? String, // картинка?
            let otvet = json["otvet"] as? Int, // интовое значение ответа
            
            let biletNumber = json["biletNumber"] as? Int, // номер билета
            let comments = json["comments"] as? String,
            let questNumber = json["questNumber"] as? Int
        
            else {
                return nil
        }
        var answers = [String]()
        let answersAndNils = json["v"] as? [Any]
        for item in answersAndNils! {
            if let answer = item as? String {
                answers.append(answer)
            }
        }
        
        
        self .title = title
        self.imageName = imageName
        self.otvet = otvet
        self.answers = answers
        self.biletNumber = biletNumber
        self.questNumber = questNumber
        self.comments = comments
        
    }
    // метод для проверки правильного ответа
    
    func answerIsCorrect(answer:String) -> Bool {
        for (_,_) in answers.enumerated() {
            if answers[otvet-1] == answer {
                return true
            }
            
        }
        
        return false
    }
    
    
    
}

