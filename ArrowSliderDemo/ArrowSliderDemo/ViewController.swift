//
//  ViewController.swift
//  ArrowSliderDemo
//
//  Created by FanFamily on 16/12/31.
//  Copyright © 2016年 niuniu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slider:ArrowSlider = ArrowSlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(slider)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        slider.frame = CGRect(x: view.frame.width - 40, y: 0, width: 40, height: view.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

