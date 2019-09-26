//
//  DimmingPresentationAnimatedTransitioning.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

class DimmingPresentationAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var animation: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        toView.backgroundColor = .clear
        containerView.addSubview(toView)
        
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        toView.frame = toViewFinalFrame
        
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration(using: transitionContext)) {
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
        animation?()
    }
}
