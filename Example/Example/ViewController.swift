//
//  ViewController.swift
//  Example
//
//  Created by yu mingming on 2019/11/20.
//  Copyright © 2019 chaozheng. All rights reserved.
//

import UIKit
//import CZKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let v = UIView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        self.view.addSubview(v)
        v.backgroundColor = cz_hexColor("#108EE9")
        //cz_print(cz_lastWindow()?.windowScene?.statusBarManager?.statusBarFrame.height, CZ.randomColor)
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CZDateSheetController.show(self) { (data) in
            cz_print(data)
        }
//        let a = CZDateSheetController()
//        a.modalPresentationStyle = .overCurrentContext
//        a.show(self, sender: <#T##Any?#>)
    }
    

}

