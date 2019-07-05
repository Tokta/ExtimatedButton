//
//  ViewController.swift
//  ExtimatedButton
//
//  Created by Alessio Sardella on 05/07/2019.
//  Copyright © 2019 Alessio Sardella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let buttonTitle = "Hello"
        let pad: CGFloat = 10
        
        let buttonHeight: CGFloat = 24
        let buttonWidth = ExtimatedButton.extimatedWidth(title: buttonTitle, height: buttonHeight)
        
        let button = ExtimatedButton(position: CGPoint(x: self.view.bounds.width - buttonWidth - pad,
                                                y: 30),
                                    height: buttonHeight,
                                    title: buttonTitle,
                                    imageName: "dartDown",
                                    imagePosition: .right)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        button.addAction { (_) in
            print("Ciao")
        }
        self.view.addSubview(button)
        
        
        let buttonBigHeight: CGFloat = 60
        let buttonBigFont: UIFont = UIFont.systemFont(ofSize: 40)
        let buttonBigWidth = ExtimatedButton.extimatedWidth(title: buttonTitle, height: buttonBigHeight, font: buttonBigFont)
        
        let buttonBig = ExtimatedButton(position: CGPoint(x: self.view.bounds.width - buttonBigWidth - pad,
                                                y: button.frame.origin.y + button.bounds.height + pad),
                              height: buttonBigHeight,
                              title: buttonTitle,
                              imageName: "dartDown",
                              imagePosition: .left,
                              font: buttonBigFont)
        buttonBig.backgroundColor = UIColor.gray
        buttonBig.layer.cornerRadius = 12
        buttonBig.layer.masksToBounds = true
        
        buttonBig.addAction { (_) in
            print("Big CIAO")
        }
        self.view.addSubview(buttonBig)
        
    }


}

