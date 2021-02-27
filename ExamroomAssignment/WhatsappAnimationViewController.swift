//
//  WhatsappAnimationViewController.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import UIKit

class WhatsappAnimationViewController: UIViewController {
   
    @IBOutlet weak var bucketImageView: BucketImageView!
    
    @IBOutlet weak var recordView: RecordView!
    

    @IBOutlet weak var recordButton: RecordButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constants.WhatUPTitle
        
    }
}
extension WhatsappAnimationViewController {
    private func setup() {
    recordButton.recordView = recordView
    }
}


