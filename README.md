# ExtimatedButton

To be sure that your UIButton looks good in any language which your project is localized, 
calculate its size based on text and font and position it based on this value:
```
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
```
