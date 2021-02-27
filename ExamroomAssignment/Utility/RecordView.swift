//
//  RecordView.swift
//  ExamroomAssignment
//
//  Created by Capgemini on 25/02/21.
//

import UIKit


public class RecordView: UIView, CAAnimationDelegate {

    private var isSwiped = false
    private var bucketImageView: BucketImageView!

    private var timer: Timer?
    private var duration: CGFloat = 0
    private var mTransform: CGAffineTransform!
    private var timerStackView: UIStackView!
    private var slideToCancelStackVIew: UIStackView!
    public var offset: CGFloat = 20
    public var isSoundEnabled = true

   private let arrow: UIImageView = {
        let arrowView = UIImageView()
        arrowView.image =  UIImage(named:"arrow")
       arrowView.translatesAutoresizingMaskIntoConstraints = false
        arrowView.tintColor = .black
        return arrowView
    }()

    private let slideLabel: UILabel = {
        let slide = UILabel()
        slide.text = "Slide To Cancel"
        slide.translatesAutoresizingMaskIntoConstraints = false
        slide.font = slide.font.withSize(12)
        return slide
    }()

//--------------------------------------------------------------------
private func setup() {
        bucketImageView = BucketImageView(frame: frame)
        bucketImageView.translatesAutoresizingMaskIntoConstraints = false
        bucketImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bucketImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timerStackView = UIStackView(arrangedSubviews: [bucketImageView])
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        timerStackView.isHidden = true
        timerStackView.spacing = 5


        slideToCancelStackVIew = UIStackView(arrangedSubviews: [arrow, slideLabel])
        slideToCancelStackVIew.translatesAutoresizingMaskIntoConstraints = false
        slideToCancelStackVIew.isHidden = true


        addSubview(timerStackView)
        addSubview(slideToCancelStackVIew)


        arrow.widthAnchor.constraint(equalToConstant: 15).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 15).isActive = true

        slideToCancelStackVIew.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        slideToCancelStackVIew.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true


        timerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        timerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }


    func onTouchDown(recordButton: RecordButton) {
        onStart(recordButton: recordButton)
    }

    func onTouchUp(recordButton: RecordButton) {
        onFinish(recordButton: recordButton)
    }


    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }


    @objc private func updateDuration() {
        duration += 1
    }

    //this will be called when user starts tapping the button
    private func onStart(recordButton: RecordButton) {
        resetTimer()

        isSwiped = false
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDuration), userInfo: nil, repeats: true)
        //reset all views to default
        slideToCancelStackVIew.transform = .identity
        recordButton.transform = .identity

        //animate button to scale up
        UIView.animate(withDuration: 0.2) {
            recordButton.transform = self.mTransform
        }
        slideToCancelStackVIew.isHidden = false
        timerStackView.isHidden = false
       
        bucketImageView.isHidden = false
        bucketImageView.resetAnimations()
        bucketImageView.animateAlpha()
      

    }

    //this will be called when user swipes to the left and cancel the record
    private func onSwipe(recordButton: RecordButton) {
        isSwiped = true

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            recordButton.transform = .identity
        })


        slideToCancelStackVIew.isHidden = true
     

        if !isLessThanOneSecond() {
            bucketImageView.animateBucketAndMic()

        } else {
            bucketImageView.isHidden = true
         }

        resetTimer()

    }

    private func resetTimer() {
        timer?.invalidate()
        duration = 0
    }

    //this will be called when user lift his finger
    private func onFinish(recordButton: RecordButton) {
        isSwiped = false

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            recordButton.transform = .identity
        })

        slideToCancelStackVIew.isHidden = true
        timerStackView.isHidden = true
        resetTimer()

    }


    //this will be called when user starts to move his finger
    func touchMoved(recordButton: RecordButton, sender: UIPanGestureRecognizer) {

        if isSwiped {
            return
        }

        let button = sender.view!
        let translation = sender.translation(in: button)

        switch sender.state {
        case .changed:

            //prevent swiping the button outside the bounds
            if translation.x < 0 {
                //start move the views
                let transform = mTransform.translatedBy(x: translation.x, y: 0)
                button.transform = transform
                slideToCancelStackVIew.transform = transform.scaledBy(x: 0.5, y: 0.5)


                if slideToCancelStackVIew.frame.intersects(timerStackView.frame.offsetBy(dx: offset, dy: 0)) {
                    onSwipe(recordButton: recordButton)
                }

            }

        case .ended:
            onFinish(recordButton: recordButton)


        default:
            break
        }

    }


}

private extension RecordView {
    func isLessThanOneSecond() -> Bool {
        return duration < 1
    }
}




