//
//  ViewController1.swift
//  DimmingTransition
//
//  Created by Guang Lei on 2019/9/26.
//  Copyright © 2019 Guang Lei. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController1 viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController1 viewWillDisappear")
    }
    
    // MARK: - Unwind segue
    
    @IBAction func unwindViewController1(_ segue: UIStoryboardSegue) {
        
    }
}

