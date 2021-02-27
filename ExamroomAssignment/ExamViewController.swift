//
//  ExamViewController.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import UIKit

class ExamViewController: UIViewController {
    @IBOutlet weak var questionLabel: UITextView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //declaring and initializing variables
    @IBOutlet weak var totalQuestionLabel: UILabel!
    var currentProgress : Int = 0
    var model : QuizViewModel = QuizViewModel()
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        addAppCycleNotifications()
        self.title = Constants.ExamTitle
    }

    @IBAction func actionQuitExam(_ sender: UIButton) {
        Constants.showAlert(title: Constants.ExamTitle, message: Constants.QuitTitle, controller: self,cancleTitle: Constants.cancleTitleNO, sucessTitle: Constants.sucessTitleYes)
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        model.getNextQuestion()
        let selectedValue = sender.currentTitle!
        let isCorrect = model.getAnswer(selectedValue)
        if isCorrect {
            sender.backgroundColor = UIColor.green
        }else{
            sender.backgroundColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            sender.backgroundColor = UIColor.clear
        })
        updateUI()
    }
}
extension ExamViewController {
    fileprivate func initialSetup() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        Constants.showAlert(title: Constants.AlertTitle, message: Constants.BodayTitle, controller: self,cancleTitle:Constants.sucessTitleOk, sucessTitle:"")
        progressBar.progress = 0
        scoreLabel.text = "Score : \(score)"
        updateUI()
    }
 
    fileprivate func updateUI() {
        progressBar.progress = model.getProgress()
        if model.questionNumber < model.questions.count {
            questionLabel.text = model.getQuestion()
        }
        scoreLabel.text = "Score : \(model.getScore())"
        totalQuestionLabel.text = " \(String(model.questionNumber) + "/" + String(model.questions.count - 1))"
        if(model.questionNumber == model.questions.count - 1) {
            Constants.showAlert(title: Constants.CongratulationTitle, message: Constants.FeedbackTitle, controller: self,cancleTitle: "", sucessTitle: Constants.sucessTitleYes)
        }
    }
    func addAppCycleNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: NSNotification.Name(Constants.JAApplicationDidEnterBackgroundNotification), object: nil)
    }

    @objc func applicationWillResignActive(notification: NSNotification) {
        let notif = LocalNotificationPublisher()
        notif.sendNotification(title: Constants.AlertTitle, subtitle: Constants.subTitle, body: Constants.BodayTitle, badge: 1, delayInterval: 1)
        Constants.showAlert(title: Constants.AlertTitle, message: Constants.QuitTitle, controller: self,cancleTitle: Constants.cancleTitleNO, sucessTitle: Constants.sucessTitleYes)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
   
    
}
