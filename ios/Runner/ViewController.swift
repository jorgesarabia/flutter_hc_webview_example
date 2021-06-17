//
//  ViewController.swift
//  Runner
//
//  Created by Jorge Sarabia on 17/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var delegate:MyProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTap(_ sender: Any) {
        delegate?.onInteractionFinish(type: "No existe URL")
        self.dismiss(animated: true, completion: nil)
    }
}
