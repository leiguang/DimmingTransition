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
    
    var presentationAnimationDuration: TimeInterval {
        return 0.35
    }
    
    var dismissalAnimationDuration: TimeInterval {
        return 0.35
    }
    
    var allowTapDimmingViewToDismiss: Bool {
        return true
    }
    func dimmingViewTapped() {}
}

class DimmingTransitioning: NSObject {
    
    private let presentationAnimatedTransitioning = DimmingPresentationAnimatedTransitioning()
    private let dismissalAnimatedTransitioning = DimmingDismissalAnimatedTransitioning()
    private var presentationController: DimmingPresentationController?
    private weak var delegate: DimmingTransitioningDelegate!
    
    override private init() {}
    
    init(viewController: UIViewController & DimmingTransitioningDelegate) {
        super.init()
        viewController.modalPresentationStyle = .custom
        delegate = viewController
        
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
        return presentationAnimatedTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissalAnimatedTransitioning
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presentationController == nil {
            presentationController = DimmingPresentationController(presentedViewController: presented, presenting: source)
            presentationController?.allowTapDimmingViewToDismiss = delegate.allowTapDimmingViewToDismiss
            presentationController?.dimmingViewTapped = { [weak self] in
                self?.delegate.dimmingViewTapped()
            }
            return presentationController
        }
        return presentationController
    }
}
