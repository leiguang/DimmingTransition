//
//  BottomPresentViewController.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2020/1/16.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit

class BottomPresentViewController: BottomPresentBaseViewController {
    
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    override var animatedBottomConstraint: NSLayoutConstraint? { contentViewBottomConstraint }
}
