//
//  BottomPresentBaseViewController.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2020/1/17.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit

class BottomPresentBaseViewController: UIViewController, DimmingTransitioningDelegate {

    private var dimmingTransitioning: DimmingTransitioning?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        dimmingTransitioning = DimmingTransitioning(delegate: self)
        transitioningDelegate = dimmingTransitioning
        modalPresentationStyle = .custom
    }
    
    func executePresentationAnimation() {
        animatedBottomConstraint?.constant = -animatedHeight
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
            self.animatedBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }

    func executeDismissalAnimation() {
        UIView.animate(withDuration: 0.25) {
            self.animatedBottomConstraint?.constant = -self.animatedHeight
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Properties or methods to override
    
    /// @Required override
    var animatedBottomConstraint: NSLayoutConstraint? { nil }
    
    /// Optional override
    var animatedHeight: CGFloat { UIScreen.main.bounds.height * 0.8 }
    
    /// Optional override
    var allowTapDimmingViewToDismiss: Bool { true }
    
    /// Optional override
    func dimmingViewTapped() {}
}
