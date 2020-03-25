//
//  DimmingTransitioning.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

protocol DimmingTransitioningDelegate: class {
    var presentationAnimationDuration: TimeInterval { get }
    var dismissalAnimationDuration: TimeInterval { get }
    
    func executePresentationAnimation()
    func executeDismissalAnimation()
    
    var allowTapDimmingViewToDismiss: Bool { get }
    func dimmingViewTapped()
}

extension DimmingTransitioningDelegate {
    var presentationAnimationDuration: TimeInterval { 0.25 }
    var dismissalAnimationDuration: TimeInterval { 0.25 }
    var allowTapDimmingViewToDismiss: Bool { true }
    func dimmingViewTapped() {}
}

class DimmingTransitioning: NSObject {
    
    private let presentationAnimatedTransitioning = DimmingPresentationAnimatedTransitioning()
    private let dismissalAnimatedTransitioning = DimmingDismissalAnimatedTransitioning()
    private weak var delegate: DimmingTransitioningDelegate!
    
    override private init() {}
    
    init(delegate: DimmingTransitioningDelegate) {
        super.init()
        self.delegate = delegate
        
        presentationAnimatedTransitioning.animationDuration = delegate.presentationAnimationDuration
        presentationAnimatedTransitioning.animation = { [weak self] in
            self?.delegate.executePresentationAnimation()
        }
        
        dismissalAnimatedTransitioning.animationDuration = delegate.dismissalAnimationDuration
        dismissalAnimatedTransitioning.animation = { [weak self] in
            self?.delegate.executeDismissalAnimation()
        }
    }
}

extension DimmingTransitioning: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimatedTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissalAnimatedTransitioning
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = DimmingPresentationController(presentedViewController: presented, presenting: source)
        presentationController.allowTapDimmingViewToDismiss = { [weak self] in
            self?.delegate.allowTapDimmingViewToDismiss ?? true
        }
        presentationController.dimmingViewTapped = { [weak self] in
            self?.delegate.dimmingViewTapped()
        }
        return presentationController
    }
}
