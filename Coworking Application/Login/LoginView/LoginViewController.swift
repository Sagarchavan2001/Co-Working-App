//
//  LoginViewController.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emaiTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    
    var iIConClick = false
    
    var imageIcon = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailIcon()
        passIcon()
        iiii()
        restoreForm1()
        self.navigationItem.setHidesBackButton(true, animated: true)

        }
    
    func restoreForm1(){
        LoginBtn.isEnabled = false
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
    }
    
    
    @IBAction func emailOrMobileTxtField(_ sender: Any) {
        if let EmailId = emaiTextField.text{
            if let errorMessage =  InvalidEmailId(EmailId){
                emailErrorLabel.text = errorMessage
                emailErrorLabel.isHidden = false
            }else{
                emailErrorLabel.isHidden = true
            }
            checkForm()
        }
        
    }
    func InvalidEmailId(_ value: String) -> String?{
        let rg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", rg)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Email Address"
        }
return nil
    }
    
    
    
    
    
    
    
    @IBAction func passwordTxtField(_ sender: Any) {
        if let Password = passwordTextField.text{
            if let errorMessage =  InvalidPassword(Password){
                passwordErrorLabel.text = errorMessage
                passwordErrorLabel.isHidden = false
            }else{
                passwordErrorLabel.isHidden = true
            }
            checkForm()
        }
        
    }
    func InvalidPassword(_ value: String) -> String?{
        let rg = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"

        let predicate = NSPredicate(format: "SELF MATCHES %@", rg)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Password"
        }
return nil
    }
    
    
    
    
    
    func checkForm(){
        if emailErrorLabel.isHidden && passwordErrorLabel.isHidden && emaiTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false  {
            LoginBtn.isEnabled = true
        }else{
            LoginBtn.isEnabled = false
        }
    }
    
    
    
    
    
    func iiii(){
        imageIcon.image = UIImage(named: "Hide1")
       let containerVeiw = UIView()
        containerVeiw.addSubview(imageIcon)
        containerVeiw.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        passwordTextField.rightView = containerVeiw
        passwordTextField.rightViewMode = .always
        let tabgeture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tabGeture:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tabgeture)
    }
    @objc func imageTapped(tabGeture:UITapGestureRecognizer){
        let tapImage = tabGeture.view as! UIImageView
        if iIConClick{
            iIConClick = false
            tapImage.image = UIImage(named: "showhide")
            
            passwordTextField.isSecureTextEntry = false
            
        }else{
            iIConClick = true
            tapImage.image = UIImage(named: "Hide1")
            passwordTextField.isSecureTextEntry = true
            }
    }
    
    func emailIcon(){
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "email")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        emaiTextField.leftView = contentView
        
        emaiTextField.leftViewMode = .always
        emaiTextField.clearButtonMode = .whileEditing
    }
    
    func passIcon(){
        let imageIcon2 = UIImageView()
        imageIcon2.image = UIImage(named: "pass")
        let contentView2 = UIView()
        contentView2.addSubview(imageIcon2)
        contentView2.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon2.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        passwordTextField.leftView = contentView2
        passwordTextField.leftViewMode = .always
       // passwordTextField.clearButtonMode = .whileEditing
    }
    
    @IBAction func createAccountBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        
        if emaiTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
           print("empty Fields")
        }else{
            
            LoginApiManager.shared.api(email: emaiTextField.text!, password: passwordTextField.text!)
            let nav3 = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
            navigationController?.pushViewController(nav3, animated: true)
        }
        
    }
    
    
    
    
    
        // Do any additional setup after loading the view.
    }
    


