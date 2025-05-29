//
//  SignUpViewController.swift
//  Login
//
//  Created by Ko Minhyuk on 5/29/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var facebookButton: UIButton!
        
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var linkedinButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonImage()
        setTextfieldStyle()
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
    
    private func setTextfieldStyle() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [.foregroundColor: UIColor.secondary])
        
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.secondary])
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.secondary])
        
        nameField.layer.cornerRadius = 16.0
        emailField.layer.cornerRadius = 16.0
        passwordField.layer.cornerRadius = 16.0
        
        nameField.layer.borderColor = UIColor.secondary.cgColor
        emailField.layer.borderColor = UIColor.secondary.cgColor
        passwordField.layer.borderColor = UIColor.secondary.cgColor
        
        nameField.layer.borderWidth = 1.0
        emailField.layer.borderWidth = 1.0
        passwordField.layer.borderWidth = 1.0
        
        nameField.layer.masksToBounds = true
        emailField.layer.masksToBounds = true
        passwordField.layer.masksToBounds = true
    }
    
    private func setButtonImage() {
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        linkedinButton.translatesAutoresizingMaskIntoConstraints = false
        
        let facebookImage = UIImage(named: "FaceBook")?.resizeImage(size: CGSize(width: 20, height: 20))
        let twitterImage = UIImage(named: "Twitter")?.resizeImage(size: CGSize(width: 20, height: 20))
        let linkedInImage = UIImage(named: "LinkedIn")?.resizeImage(size: CGSize(width: 20, height: 20))
        facebookButton.setImage(facebookImage, for: .normal)
        twitterButton.setImage(twitterImage, for: .normal)
        linkedinButton.setImage(linkedInImage, for: .normal)
    }
}
