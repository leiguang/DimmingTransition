//
//  BottomPresentDelegateObject.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2020/1/16.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

//import UIKit
//
//protocol BottomPresentTransitioningDelegate: class {
//    var contentViewBottomConstraint: NSLayoutConstraint? { get }
//    var contentViewHeight: CGFloat { get }
//
//    var allowTapDimmingViewToDismiss: Bool { get }
//    func dimmingViewTapped()
//}
//
//extension BottomPresentTransitioningDelegate {
//    var contentViewHeight: CGFloat { UIScreen.main.bounds.height * 0.8 }
//    var allowTapDimmingViewToDismiss: Bool { true }
//    func dimmingViewTapped() {}
//}
//
//class BottomPresentTransitioning: DimmingTransitioningDelegate {
//
//    var dimmingTransitioning: DimmingTransitioning!
//
//    weak var delegate: (UIViewController & BottomPresentTransitioningDelegate)? {
//        didSet {
//            dimmingTransitioning = DimmingTransitioning(delegate: self)
//            delegate?.transitioningDelegate = dimmingTransitioning
//            delegate?.modalPresentationStyle = .custom
//        }
//    }
//
//    func executePresentationAnimation() {
//        guard let delegate = delegate else { return }
//        delegate.contentViewBottomConstraint?.constant = -delegate.contentViewHeight
//        delegate.view.layoutIfNeeded()
//
//        UIView.animate(withDuration: 0.25) {
//            delegate.contentViewBottomConstraint?.constant = 0
//            delegate.view.layoutIfNeeded()
//        }
//    }
//
//    func executeDismissalAnimation() {
//        guard let delegate = delegate else { return }
//        UIView.animate(withDuration: 0.25) {
//            delegate.contentViewBottomConstraint?.constant = -delegate.contentViewHeight
//            delegate.view.layoutIfNeeded()
//        }
//    }
//
//    var allowTapDimmingViewToDismiss: Bool {
//        delegate?.allowTapDimmingViewToDismiss ?? false
//    }
//
//    func dimmingViewTapped() {
//        delegate?.dimmingViewTapped()
//    }
//}
//
//enum DimmingTransitionStyle {
//    case bottomPresent
//}
//
//private var dimmingTransitionKey: Void?
//
//extension BottomPresentTransitioningDelegate where Self: UIViewController {
//
////    var bottomPresentDelegateObject: BottomPresentTransitioning? {
////        get {
////            objc_getAssociatedObject(self, &bottomPresentTransitioningKey) as? BottomPresentTransitioning
////        }
////        set {
////            newValue?.delegate = self
////            objc_setAssociatedObject(self, &bottomPresentTransitioningKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
////        }
////    }
//}
