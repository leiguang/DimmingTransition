//
//  DimmingTransitioning.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

protocol DimmingTransitioningDelegate: class {
    func executePresentationAnimation()
    func executeDismissalAnimation()
    
    /// Note: There is a bug, the dimming view is not in the view hierarchy of presented view controller, so the tap event can't be passed to dimming view.
//    var allowTapDimmingViewToDismiss: Bool { get }
//    func dimmingViewTapped()
}

extension DimmingTransitioningDelegate {
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
        presentationAnimatedTransitioning.animation = { [weak self] in
            self?.delegate.executePresentationAnimation()
        }
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
