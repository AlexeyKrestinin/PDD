//
//  PddViewController.swift
//  PDD
//
//  Created by Алексей Крестинин on 13.03.17.
//  Copyright © 2017 Alexey Krestinin. All rights reserved.
//

import UIKit

class PddViewController: UIViewController {
    
    //------------------------------- STORYBOARD
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var questionText: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var progressView: UIProgressView!
    
    //------------------------------- END STORYBOARD
    
    //------------------------------- PROPERTIES
    
    var biletNum = "b2"
    // это вычисляемое свойство которое позволяет понять, виден ли вью нашего
    var isOnScreen:Bool {
        // проверим что у нас уже загружен вью и что у вью есть свойство window
        // если без isViewLoaded то будет очень долго проверятся. Обе функции встроенные
        return isViewLoaded && view.window != nil
    }
    
    var questionList:[Question]? // тут будут храниться все вопросы
        {
        // когда сюда будут записаны новые вопросы
        // возьмем первый из них и запишем в currentQuestion
        didSet {
            currentQuestionIndex = 0
            score = 0
            currentQuestion = questionList?.first
        }
    }
    
    var currentQuestionIndex = 0 //  индекс текущего вопроса
    
    var score = 0
    
    var currentQuestion:Question? // тут будет отображаться текущий вопрос
        {
        // как только значение изменилось значение currentQuestion изменилось
        // перезагрузим содержимое таблицы с правильными ответами
        didSet {
            updateViews ()
        }
    }
    
    
    //------------------------------- END PROPERTIES
    
    //------------------------------- VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setup ()
        // Do any additional setup after loading the view.
    }
    
    //------------------------------- END VIEWDIDLOAD
    
    //------------------------------- METODS
    
    // Подготовка к переходу на экран с результатом
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // если мы переходим на resultViewCOntroller
        if let destVC = segue.destination as? ResultViewController,
            // и параметром является объект типа Int
            let scoreToShow = sender as? Int {
            destVC.score = scoreToShow
            
            
        }
    }
    
    
    private func updateViews () {
        
        
        let sectionsToReload = IndexSet(integer: 0)
        self.tableView.reloadSections(sectionsToReload, with: isOnScreen ? .left : .none) // вместо reloadData, при использовании анимации
        
        // Создаем метод для анимации
        let duration = isOnScreen ? 0.2 : 0 // если на экране то 0.2, если нет то 0
        
        UIView.animate(withDuration: duration, animations: {
            // сделаем наши вью прозрачными
            self.questionText.alpha = 0
            self.imageView.alpha = 0
        }, completion: { finished in
            // эта часть вызывается по завершении анимации
            self.questionText.text = self.currentQuestion?.title
            
            self.imageView.image = self.currentQuestion?.image
            
            self.progressView.progress = Float(self.currentQuestionIndex) / 20
            
            UIView.animate(withDuration: duration, animations: {
                self.questionText.alpha = 1
                self.imageView.alpha = 1 },
                           completion: nil)
        })
        
        
        
    }
    
    private func setup () {
        tableView.dataSource = self // tableView не знает что показывать. и чтобы это узнать обращается к self - questionsviewcontroller. Отвечает за то, ЧТО мы показываем.
        tableView.delegate = self // что делать, если произошло действие с tableView. МОжно ли показывать элементы удаления, что делать при нажатии на ячейку.
        // Зададим динамическую высоту ячеек таблицы
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
        loadData ()
        
    }
    
    
    private func loadData() {
        // создали объект, который загрузит данные
        let loader = DataLoader()
        let result = loader.loadData(fileName: biletNum)
        // вывели результат в консоль
        //        print (result)
        
        
        self.title = "Номер билета:\(biletNum), номер вопроса:\(currentQuestionIndex + 1)" // у viewController есть свойство title
        self.questionList = result
        
        
    }
    
    
    //------------------------------- END METODS
    
    
}

extension PddViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // проверим наш ответ
        //
        let selectedAnswer = currentQuestion?.answers[indexPath.row]
        if currentQuestion?.answerIsCorrect(answer: selectedAnswer!) ?? false { // ?? false - значит, что если в нашем опциональном значении Bool пусто то просто вернем false
            score += 1
        }
        print ("Ячейка с индексом \(indexPath) выбрана счет = \(score)")
        // увеличим индекс вопроса на 1
        currentQuestionIndex += 1
        guard currentQuestionIndex < questionList?.count ?? 0 else {
            print ("дальше не пойдем")
            
            // вычислим счет и передадим дальше
            
            let score = self.score
            
            // запустим переход на новый экран
            // название перехода SHow Result
            performSegue(withIdentifier: "Show Result", sender: Int(score))
            
            
            return
        }
        currentQuestion = questionList?[currentQuestionIndex]
        // самое время перейти к след вопросу
        
        
    }
}

extension PddViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // если вдруг у нас нет текущего вопроса, то мы передадим значение по умолчанию
        return self.currentQuestion?.answers.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // в ячейках таблицы мы будем показывать ответы на вопросы
        // одна ячейка - один ответ
        // 0 я ячейка - 0 ответ
        // 1 я ячейка - 1 ответ итд
        
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row]
        
        return cell
        
    }
    
}










