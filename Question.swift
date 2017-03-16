//
//  Question.swift
//  PDD
//
//  Created by Алексей Крестинин on 13.03.17.
//  Copyright © 2017 Alexey Krestinin. All rights reserved.
//

import UIKit

struct Question {
    let title:String // заголовок
    let answers:[String]  // Варианты ответов
    let biletNumber:Int
    let questNumber:Int // номер вопроса
    let comments:String
    
    private let imageName:String
    private let otvet:Int // номер правильного ответа
    
    // ЗАГРУЗКА КАРТИНКИ ИЗ ИНТЕРНЕТА
    
    var image:UIImage? {
        let url = URL(string: imageName)
        guard let data = try? Data(contentsOf: url!) else {
            return nil
        }
        return UIImage(data:data)
    }
    
    init? (json:[String:Any]) {
        
        guard let title = json["quest"] as? String, // Заголовок равен вопросу
            let otvet = json["otvet"] as? Int, // интовое значение ответа
            let biletNumber = json["biletNumber"] as? Int, // номер билета
            let comments = json["comments"] as? String,
            let questNumber = json["questNumber"] as? Int
            
            else {
                return nil
        }
        
        // ПРОВЕРКА НА СООТВЕТСТВИЕ МАССИВА - УСЛОВИЮ МАССИВ СТРОК (ОТСЕИВАЕМ ИЗ МАССИВА NULL ИТД)
        var answers = [String]()
        let answersAndNils = json["v"] as? [Any]
        for item in answersAndNils! {
            if let answer = item as? String {
                answers.append(answer)
            }
        }
        
        // БЕЗ ЭТОГО, ВОПРОСЫ БЕЗ КАРТИНОК НЕ ОТОБРАЖАЮТСЯ!
        var imageName = "http://400km.ru/images_b_2013/NoPicture.png"
        if let imageName1 = json["realUrl"] as? String {
            imageName = imageName1
        }
        
        
        self.title = title
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

