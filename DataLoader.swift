//
//  DataLoader.swift
//  PDD
//
//  Created by Алексей Крестинин on 13.03.17.
//  Copyright © 2017 Alexey Krestinin. All rights reserved.
//

import Foundation

class DataLoader {
    
    // 1. Открыть файл
    // 2. Преобразовать его в словарь
    // 3. Достать оттуда вопросы и название
    func loadData(fileName:String) -> (biletName:String,questions:[Question])
    {
        // найдем путь к искомому файлу
        let pathToFile = Bundle.main.path(forResource: fileName, ofType: "json")!
        
        // Это печать пути к файлу внутри приложения
        print (pathToFile)
        
        // прочитаем поток байт из найденного пути
        let data = try! Data(contentsOf:URL(fileURLWithPath: pathToFile))
        
        // объект типа Any, который почти готов к использованию
        let json = try! JSONSerialization.jsonObject(with: data, options:[])
     
        // преобраззовали тип Any в [String:Any]
        // будет создан объект, описывающий содержимое файла
        // у него будут ключи - строки и значения - все, что угодно.
        
        guard let bilets = json as? [[String:Any]] else {
            fatalError("Ошибка, не могу прочитать билет")
        }
        
        var biletName = "Номер билета"
        var questions = [Question] ()
        for element in bilets {
            if let slovar = element as? [String:Any] {
//                print ("\(slovar)")
                if let aQuestion = Question(json:slovar) {
                        questions.append(aQuestion)
                }
            }
        }
        
     
        
//        guard let bilet = bilets[0] as? [String:Any] else {
//            fatalError("ебись конем")
//        }
//        print ("\(bilet)")
        
//        guard let biletName = bilets["biletName"] as? Int else {
//            fatalError("Где номер билета?")
//        }
//        print ("\(biletName)")
        
        
        
        
        
        // попытаемся достать имя викторины по ключу name - > string
//        guard let quizName = questionsJSON["name"] as? String,
        
            // а так же, получить список вопросов, по ключу "question"
            // там должен лежать массив из словарей
            // у словарей тип [String:Any]
            
//            let jsonsToConvert = questionsJSON["questions"] as? [[String:Any]] else {
//                fatalError("не корректный формат викторины")
//        }
        // осталось преобразовать описание вопросов в модель
        
        // сиюда мы будем вставлять вопросы
        
      
//        for json in jsonsToConvert {
//            if let aQuestion = Question(json:json) {
//                questions.append(aQuestion)
//            }
//        }
//        
//        if questions.count == 0 {
//            fatalError("Не создано ни одного вопроса")
//        }
        
        return (biletName,questions)
    }
}
