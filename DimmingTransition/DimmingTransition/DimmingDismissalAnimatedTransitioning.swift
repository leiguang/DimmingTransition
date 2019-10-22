//
//  DimmingDismissalAnimatedTransitioning.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

class DimmingDismissalAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
   
    var animationDuration: TimeInterval = 0.35
    
    var animation: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let fromView = transitionContext.view(forKey: .from) else {
                return
        }
        
        fromView.frame = transitionContext.finalFrame(for: fromViewController)

        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration(using: transitionContext)) {
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
        animation?()
    }
}
