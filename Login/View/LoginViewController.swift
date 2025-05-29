//
//  LoginViewController.swift
//  Login
//
//  Created by Ko Minhyuk on 5/29/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var facebookButton: UIButton!
        
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var linkedinButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func forgotAction(_ sender: Any) {
        print(#function, "LoginView Forgot Password")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setButtonImage()
        setTextfieldStyle()
        setButtonStyle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setButtonStyle() {
        var config = UIButton.Configuration.plain()
        var attributes = AttributeContainer()
        
        attributes.font = .systemFont(ofSize: 16, weight: .bold)
        
        config.attributedTitle = AttributedString("Sign Up", attributes: attributes)
                
        config.baseForegroundColor = UIColor.primary
        config.contentInsets = .zero
        
        signupButton.configuration = config
        
        forgotButton.configuration = .plain()
        forgotButton.configuration?.baseForegroundColor = UIColor.label
        forgotButton.configuration?.contentInsets = .zero
        attributes.font = .systemFont(ofSize: 15)
        forgotButton.configuration?.attributedTitle = AttributedString("Forgot Password", attributes: attributes)
    }
    
    private func setTextfieldStyle() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.layer.cornerRadius = 16.0
        passwordTextField.layer.cornerRadius = 16.0
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.secondary])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.secondary])
        
        emailTextField.layer.borderColor = UIColor.secondary.cgColor
        passwordTextField.layer.borderColor = UIColor.secondary.cgColor
        
        emailTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderWidth = 1.0
        
        emailTextField.layer.masksToBounds = true
        passwordTextField.layer.masksToBounds = true
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


extension UIImage {
    func resizeImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
