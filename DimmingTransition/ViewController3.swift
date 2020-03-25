//
//  ViewController3.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, DimmingTransitioningDelegate {
    
    // MARK: - Object lifecycle
    
    var dimmingTransitioning: DimmingTransitioning!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        dimmingTransitioning = DimmingTransitioning(delegate: self)
        transitioningDelegate = dimmingTransitioning
        modalPresentationStyle = .custom
    }
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController3 viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController3 viewWillDisappear")
    }
    
    // MARK: - DimmingTransitioningDelegate
    
    @IBOutlet weak var contentView: UIView!
    
    var presentationAnimationDuration: TimeInterval {
        return 0.5
    }
    
    var dismissalAnimationDuration: TimeInterval {
        return 0.5
    }
    
    func executePresentationAnimation() {
        contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        contentView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.contentView.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = .identity
            }
        }
    }
    
    func executeDismissalAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.contentView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.contentView.alpha = 0
        }
    }
        
    var allowTapDimmingViewToDismiss: Bool {
        return false
    }
    
    func dimmingViewTapped() {
        print(#function)
        //        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Unwind segue
    
    @IBAction func unwindViewController3(_ segue: UIStoryboardSegue) {}
}
