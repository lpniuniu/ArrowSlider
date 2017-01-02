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
        slider.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

