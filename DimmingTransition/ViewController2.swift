//
//  ViewController2.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, DimmingTransitioningDelegate {
    
    // MARK: - Object lifecycle
    
    var dimmingTransitioning: DimmingTransitioning?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        dimmingTransitioning = DimmingTransitioning(viewController: self)
        transitioningDelegate = dimmingTransitioning
    }
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController2 viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController2 viewWillDisappear")
    }
    
    // MARK: - DimmingTransitioningDelegate
    
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    func executePresentationAnimation() {
        contentViewBottomConstraint.constant = -650
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.contentViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func executeDismissalAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.contentViewBottomConstraint.constant = -650
            self.view.layoutIfNeeded()
        }
    }
    
    func dimmingViewTapped() {
        print(#function)
    }
    
    // MARK: - Unwind segue
    
    @IBAction func unwindViewController2(_ segue: UIStoryboardSegue) {}
}
