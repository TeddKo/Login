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

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonImage()
        setTextfieldStyle()
        setButtonStyle()
        setupDelegates()
        setupTextFieldActions()
        updateLoginButtonState()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }

    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupTextFieldActions() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc private func textFieldDidChange() {
        updateLoginButtonState()
    }

    
    @IBAction func forgotAction(_ sender: Any) {
        print(#function, "LoginView Forgot Password")
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        print(#function, "LoginButton Email: \(email), Password: \(password)")
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
        attributes.font = .systemFont(ofSize: 13)
        forgotButton.configuration?.attributedTitle = AttributedString("Forgot Password", attributes: attributes)

        loginButton.isEnabled = false
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
        
        let emailLeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.leftView = emailLeftPaddingView
        emailTextField.leftViewMode = .always

        let emailRightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
        emailTextField.rightView = emailRightPaddingView
        emailTextField.rightViewMode = .always
        
        let passwordLeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordLeftPaddingView
        passwordTextField.leftViewMode = .always
        
        let passwordRightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.rightView = passwordRightPaddingView
        passwordTextField.rightViewMode = .always
    }

    private func setButtonImage() {
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        linkedinButton.translatesAutoresizingMaskIntoConstraints = false

        let facebookImage = UIImage(named: "facebook")?.resizeImage(size: CGSize(width: 20, height: 20))
        let twitterImage = UIImage(named: "twitter")?.resizeImage(size: CGSize(width: 20, height: 20))
        let linkedInImage = UIImage(named: "linkedin")?.resizeImage(size: CGSize(width: 20, height: 20))
        facebookButton.setImage(facebookImage, for: .normal)
        twitterButton.setImage(twitterImage, for: .normal)
        linkedinButton.setImage(linkedInImage, for: .normal)
    }

    

    private func updateLoginButtonState() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let isEmailValid = isValidEmail(email)
        let isPasswordValid = isValidPassword(password)
        loginButton.isEnabled = isEmailValid && isPasswordValid
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            if loginButton.isEnabled {
                loginButtonAction(loginButton)
            }
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UIImage {
    func resizeImage(size: CGSize) -> UIImage? {
        guard size.width > 0 && size.height > 0 else {
            print("Error: Invalid size for image resizing: \(size)")
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return resizedImage
    }
}


public func isValidEmail(_ email: String) -> Bool {
    guard email.count >= 6 && email.count <= 20 else { return false }
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

public func isValidPassword(_ password: String) -> Bool {
    let uppercaseLetterRegEx = ".*[A-Z]+.*"
    let uppercaseLetterPred = NSPredicate(format:"SELF MATCHES %@", uppercaseLetterRegEx)
    guard uppercaseLetterPred.evaluate(with: password) else { return false }

    var hasLowercase = false
    for char in password {
        if char.isLowercase {
            hasLowercase = true
            break
        }
    }
    guard hasLowercase else { return false }

    let numberRegEx = ".*[0-9]+.*"
    let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
    guard numberPred.evaluate(with: password) else { return false }

    let specialCharacterRegEx = ".*[\\p{P}\\p{S}].*"
    let specialCharacterPred = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
    guard specialCharacterPred.evaluate(with: password) else { return false }
    
    guard password.count >= 8 else { return false }

    return true
}
