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
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var mainLoginButton: UIButton!
    
    @IBAction func forgotAction(_ sender: Any) {
        print(#function, "SignUpView Forgot Password")
    }
    @IBAction func loginAction(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func mainLoginAction(_ sender: UIButton) {
        guard let name = nameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        print(#function, "SignUpView LoginButton Name: \(name) Email: \(email), Password: \(password)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonImage()
        setTextfieldStyle()
        setButtonStyle()
        setupTextFieldActions()
        setupDelegates()
        updateLoginButtonState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        nameField.becomeFirstResponder()
    }
    
    private func setupDelegates() {
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    private func setupTextFieldActions() {
        nameField.addTarget(self, action: #selector(textFielddidChange), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFielddidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFielddidChange), for: .editingChanged)
    }
    
    @objc private func textFielddidChange() {
        updateLoginButtonState()
    }
    
    private func setButtonStyle() {
        var config = UIButton.Configuration.plain()
        var attributes = AttributeContainer()
        
        attributes.font = .systemFont(ofSize: 16, weight: .bold)
        
        config.attributedTitle = AttributedString("Log In", attributes: attributes)
        
        config.baseForegroundColor = UIColor.black
        config.contentInsets = .zero
        
        loginButton.configuration = config
        
        forgotButton.configuration = .plain()
        forgotButton.configuration?.baseForegroundColor = UIColor.label
        forgotButton.configuration?.contentInsets = .zero
        attributes.font = .systemFont(ofSize: 13)
        forgotButton.configuration?.attributedTitle = AttributedString("Forgot Password", attributes: attributes)
        
        mainLoginButton.isEnabled = false
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
        
        let nameLeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailField.frame.height))
        nameField.leftView = nameLeftPaddingView
        nameField.leftViewMode = .always

        let nameRightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailField.frame.height))
        nameField.rightView = nameRightPaddingView
        nameField.rightViewMode = .always
        
        let emailLeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailField.frame.height))
        emailField.leftView = emailLeftPaddingView
        emailField.leftViewMode = .always

        let emailRightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailField.frame.height))
        emailField.rightView = emailRightPaddingView
        emailField.rightViewMode = .always
        
        let passwordLeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordField.frame.height))
        passwordField.leftView = passwordLeftPaddingView
        passwordField.leftViewMode = .always
        
        let passwordRightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordField.frame.height))
        passwordField.rightView = passwordRightPaddingView
        passwordField.rightViewMode = .always
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
    
    private func isValidName(_ name: String) -> Bool {
        guard name.count >= 2 && name.count <= 5 else { return false }
        let nameRegEx = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]+$"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    private func updateLoginButtonState() {
        guard let name = nameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        let isNameValid = isValidName(name)
        let isEmailVAlid = isValidEmail(email)
        let isPasswordValid = isValidPassword(password)
        
        mainLoginButton.isEnabled = isNameValid && isEmailVAlid && isPasswordValid
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            if mainLoginButton.isEnabled {
                mainLoginAction(mainLoginButton)
            }
            textField.resignFirstResponder()
        }
        return true
    }
}
