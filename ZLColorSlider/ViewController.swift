//
//  ViewController.swift
//  ZLColorSlider
//
//  Created by issam on 12/07/2016.
//  Copyright © 2016 ZetaLearning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var colorView: UIView!
    @IBOutlet var slider: ZLColorSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        slider.color = colorView.backgroundColor!

    }
    @IBAction func sliderDidChange(sender: ZLColorSlider) {
        colorView.backgroundColor = sender.color
    }
}

