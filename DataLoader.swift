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
    func loadData(fileName:String) -> [Question]
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
        
        var questions = [Question] ()
        

        for element in bilets {
//                print ("\(slovar)")
            if let aQuestion = Question(json:element){
//                    print ("\(aQuestion)")
                        questions.append(aQuestion)
            }
        
        }
        if questions.count == 0 {
            fatalError("Не создано ни одного вопроса")
        }
     
        return (questions)
    }
}
