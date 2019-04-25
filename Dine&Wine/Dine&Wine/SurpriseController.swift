//
//  SurpriseController.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 24/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import UIKit
import SAConfettiView

class SurpriseController: UIViewController {
    
    var confettiView: SAConfettiView!
    var isRainingConfetti = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create confetti view
        confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                               UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                               UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                               UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                               UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        
        confettiView.intensity = 1
        confettiView.type = .Confetti
        view.addSubview(confettiView)
        confettiView.startConfetti()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isRainingConfetti) {
            confettiView.stopConfetti()
        } else {
            confettiView.startConfetti()
        }
        isRainingConfetti = !isRainingConfetti
    }
    
}

