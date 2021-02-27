//
//  iGesutreRecognizer.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 27/02/21.
//

import Foundation
import UIKit
protocol GesutreDelegate {
    func onStart()
    func onEnd()
}
class iGesutreRecognizer: UIGestureRecognizer {
    var gestureDelegate: GesutreDelegate?


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        gestureDelegate?.onStart()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        gestureDelegate?.onEnd()
    }

}
