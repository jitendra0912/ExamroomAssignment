//
//  Constants.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import Foundation
import UIKit
class Constants
{
    public static let JAApplicationDidEnterBackgroundNotification = "JAApplicationDidEnterBackgroundNotification"
    public static let AlertTitle = "Alert"
    public static let subTitle = "Exam Mode"
    public static let BodayTitle = "Your are in exam mode don't move to any screen or background, Otherwise data will loss!"
    public static let WhatUPTitle = "WhatsApp Screen"
    public static let ExamTitle = "Exam Screen"
    public static let HomeTitle = "Home Screen"
    public static let CongratulationTitle = "Congratulations!"
    public static let FeedbackTitle = "Thank you! you have done the exam will let you know your feedback!"
    public static let QuitTitle = "You want to quit the exam"
    public static let cancleTitleNO = "No"
    public static let sucessTitleYes = "Yes"
    public static let sucessTitleOk = "Ok"
    
    public static func showAlert(title:String?, message:String, controller:UIViewController, cancleTitle:String, sucessTitle:String) {
        let alert = UIAlertController(title: title ?? "", message:message ?? "" , preferredStyle: UIAlertController.Style.alert)
        
        if (!cancleTitle.isEmpty ) {
            alert.addAction(UIAlertAction(title: cancleTitle, style: UIAlertAction.Style.default, handler: { _ in
            }))
        }
       
        if (!sucessTitle.isEmpty ) {
            alert.addAction(UIAlertAction(title: sucessTitle,
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                                            controller.navigationController?.popToRootViewController(animated: true)
                                            
                                          }))
        }
        
        
        controller.present(alert, animated: true, completion: nil)
    }
}
