//
//  DimmingPresentationController.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    
    private var dimmingView: UIView?
    
    var allowTapDimmingViewToDismiss = true
    var dimmingViewTapped: (() -> Void)?
    
    override func presentationTransitionWillBegin() {
        if let containerView = containerView {
            let dimmingView = UIView(frame: containerView.bounds)
            dimmingView.backgroundColor = UIColor.black
            dimmingView.isOpaque = false
            dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDimmingView(_:))))
            dimmingView.isUserInteractionEnabled = allowTapDimmingViewToDismiss
            self.dimmingView = dimmingView
            containerView.addSubview(dimmingView)
            
            dimmingView.alpha = 0
            presentingViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) in
                self?.dimmingView?.alpha = 0.5
            }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (_) in
            self?.dimmingView?.alpha = 0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView = nil
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        if let containerView = containerView {
            dimmingView?.frame = containerView.bounds
        }
    }
    
    @objc private func tapDimmingView(_ sender: UITapGestureRecognizer) {
        dimmingViewTapped?()
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
