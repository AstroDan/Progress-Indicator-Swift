//
//  ViewController.swift
//  Progress Indicator Swift
//
//  Created by Dan on 23/08/2014.
//
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var progressIndicator: ProgressIndicator!
    
    @IBOutlet weak var progressIndicator2: ProgressIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.progressIndicator.tintColor = UIColor(patternImage: UIImage(named:"Texture"))
        self.progressIndicator2.backgroundColor = UIColor(patternImage: UIImage(named:"Texture"))
        self.progressIndicator2.edgeInsets = UIEdgeInsetsMake(14, 10, 14, 10)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

