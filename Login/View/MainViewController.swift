//
//  ViewController.swift
//  Login
//
//  Created by Ko Minhyuk on 5/29/25.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginButtonStyle()
    }
    
    private func setLoginButtonStyle() {
        var config = UIButton.Configuration.plain()
        var attributes = AttributeContainer()
        
        attributes.font = .systemFont(ofSize: 16, weight: .bold)
        
        config.attributedTitle = AttributedString("Log In", attributes: attributes)
        
        config.baseForegroundColor = UIColor.black
        config.contentInsets = .zero
        
        loginButton.configuration = config
    }
}
