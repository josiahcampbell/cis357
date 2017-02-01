import UIKit
import Foundation

class ViewController: UIViewController {

    enum Validation {
        private static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", Validation.emailPattern)
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField! // implicityly unwrapped
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(dismissKeyboard))
        view.addGestureRecognizer(detectTouch)
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        validateFields()
    }
    
    func validateFields() {
        if validateEmail() && validatePassword() {
             print("Congratulations! You entered correct values.")
        }
    }
    
    func validatePassword() -> Bool {
        var passwordIsValid = false
        if let password = passwordField.text {
            passwordIsValid = !password.isEmpty
        } else {
            print("Password cannot be blank!")
        }
        return passwordIsValid
    }
    
    func validateEmail() -> Bool {
        var emailIsValid = false
        if let email = emailField.text {
            emailIsValid = Validation.emailPredicate.evaluate(with: email)
        } else {
            print("Invalid email address :(")
        }
        return emailIsValid
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            self.passwordField.becomeFirstResponder()
        } else {
            validateFields()
        }
        return true
    }
}
