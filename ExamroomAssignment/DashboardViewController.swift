//
//  ViewController.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constants.HomeTitle
    }
    @IBAction func actionWhatsupAnimation(_ sender: UIButton) {
        let whatupViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WhatsappAnimationViewController") as! WhatsappAnimationViewController
        self.navigationController?.pushViewController(whatupViewController, animated: true)
    }
    
    
    @IBAction func actionExamScreen(_ sender: UIButton) {
        let examViewController =  self.storyboard?.instantiateViewController(withIdentifier: "ExamViewController") as! ExamViewController
        
        self.navigationController?.pushViewController(examViewController, animated: true)
    }
}

