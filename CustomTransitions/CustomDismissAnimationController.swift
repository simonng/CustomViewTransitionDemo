//
//  CustomDismissAnimationController.swift
//  CustomTransitions
//
//  Created by Joyce Echessa on 3/3/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class CustomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0.5
        containerView.addSubview(toViewController.view)
        containerView.sendSubviewToBack(toViewController.view)
        
        let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = fromViewController.view.frame
        containerView.addSubview(snapshotView!)
        
        fromViewController.view.removeFromSuperview()
        
        UIView.animate(withDuration:transitionDuration(using: transitionContext) , animations: {
            snapshotView?.frame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2) //CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 2, fromViewController.view.frame.size.height / 2)
            toViewController.view.alpha = 1.0
        }) { finished in
            snapshotView?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
