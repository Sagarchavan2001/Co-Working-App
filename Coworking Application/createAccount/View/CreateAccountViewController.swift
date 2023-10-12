//
//  CreateAccountViewController.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
  //Mark - Outlets for Element..
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var mobileNumberError: UILabel!
    @IBOutlet weak var EmailError: UILabel!
    @IBOutlet weak var createAccBtn: UIButton!
    
//Mark - viewDidLoad..
    override func viewDidLoad() {
        super.viewDidLoad()
        emailIcon()
        NameIcon()
        mobileIcon()
        restoreForm()
    }
    
//Mark function For Restore Form..
    func restoreForm(){
        createAccBtn.isEnabled = false
        nameError.isHidden = true
        mobileNumberError.isHidden = true
        EmailError.isHidden = true
    }
 //Mark -  Name TextField..
    @IBAction func NameTxtField(_ sender: Any) {
        if let Name = fullNameTextField.text{
            if let errorMessage =  InvalidName(Name){
                nameError.text = errorMessage
                nameError.isHidden = false
            }else{
                nameError.isHidden = true
            }
            checkForm()
        }
    }
//Mark function For Invalid Name..
    func InvalidName(_ value: String) -> String?{
        let rg = "^[a-zA-Z' -]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", rg)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Full Name"
        }
return nil
    }
    
//Mark-  Mobile Number TextField
    @IBAction func mobileNumberTxtField(_ sender: Any) {
        if let Mobile = mobileNumberTextField.text{
            if let errorMessage =  InvalidMobile(Mobile){
                mobileNumberError.text = errorMessage
                mobileNumberError.isHidden = false
            }else{
                mobileNumberError.isHidden = true
            }
            checkForm()
        }
    }
    func InvalidMobile(_ value: String) -> String?{
        let rg = "^[7-9][0-9]{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", rg)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Mobile Number"
        }
return nil
    }

    //Mark-  Mobile Number TextField
    @IBAction func emailTxtField(_ sender: Any) {
        if let email = EmailTextField.text{
            if let errorMessage =  InvalidEmail(email){
                EmailError.text = errorMessage
                EmailError.isHidden = false
            }else{
                EmailError.isHidden = true
            }
            checkForm()
        }
        
    }
    func InvalidEmail(_ value: String) -> String?{
        let rg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", rg)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Email Address"
        }
return nil
    }
    
//Mark- function for checking..
    func checkForm(){
        if nameError.isHidden && mobileNumberError.isHidden && EmailError.isHidden && fullNameTextField.text?.isEmpty == false && mobileNumberTextField.text?.isEmpty == false  && EmailTextField.text?.isEmpty == false {
            createAccBtn.isEnabled = true
        }else{
            createAccBtn.isEnabled = false
        }
    }
    //Mark- function for Name Icon Image..
    func NameIcon(){
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "nameImage")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        fullNameTextField.leftView = contentView
        
        fullNameTextField.leftViewMode = .always
        fullNameTextField.clearButtonMode = .whileEditing
    }
    
    //Mark- function for Email Icon..
    func emailIcon(){
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "email")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        EmailTextField.leftView = contentView
        
        EmailTextField.leftViewMode = .always
        EmailTextField.clearButtonMode = .whileEditing
    }
//Mark- function for Mobile Icon..
    func mobileIcon(){
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "call")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        mobileNumberTextField.leftView = contentView
        mobileNumberTextField.leftViewMode = .always
        mobileNumberTextField.clearButtonMode = .whileEditing
    }
    
//Mark - Create Account Button...
    @IBAction func createAccountButton(_ sender: Any) {
        if EmailTextField.text?.isEmpty == true && mobileNumberTextField.text?.isEmpty == true && fullNameTextField.text?.isEmpty == true{
           print("empty Fields")
        }else{
            //Mark - Api Calling..
            createAccountApiManager.shared.api(email: EmailTextField.text!, name: fullNameTextField.text!)
            //Mark -  Navigation...
            let nav = storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
            navigationController?.pushViewController(nav, animated: true)
        }
        
    }
   
    //Mark -  Login Button...
    @IBAction func LoginInBtn(_ sender: Any) {
        let nav = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
        navigationController?.pushViewController(nav, animated: true)
    }
    }
    
    

