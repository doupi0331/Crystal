//
//  RegisterVC.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/12.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passConfirmTxt: UITextField!
    @IBOutlet weak var birthdateTxt: UITextField!
    
    let datePicker = UIDatePicker()
    var data = [String : Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTxt.delegate = self
        lastNameTxt.delegate = self
        phoneTxt.delegate = self
        passwordTxt.delegate = self
        passConfirmTxt.delegate = self
        
        createDatePicker()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        let firstName = firstNameTxt.text!
        let lastName = lastNameTxt.text!
        let phone = phoneTxt.text!
        let birthdate = birthdateTxt.text!
        let password = passwordTxt.text!
        let passConfirm = passConfirmTxt.text!
        
        if firstName.isEmpty || lastName.isEmpty || phone.isEmpty || birthdate.isEmpty || password.isEmpty || passConfirm.isEmpty {
            let alert = MESSAGE(title: "", message: "請填妥所有欄位")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if password != passConfirm {
            let alert = MESSAGE(title: "", message: "確認密碼與密碼不符，請再重新輸入")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        data = ["first_name" : firstName,
                "last_name" : lastName,
                "phone" : phone,
                "birthdate" : birthdate,
                "password" : password,
                "password_confirmation" : passConfirm]
        
        self.signUp {
            
            // sign up successed!
            let alert = UIAlertController(title: "", message: "註冊成功，歡迎使用Crystal會員App", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default){
                action in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // textField position fixing and keyboard displaying
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let stackView = textField.superview as? UIStackView
        let frame = stackView?.frame
        let offset = (frame?.origin.y)! + 100 - (self.view.frame.size.height-300)
        
        if offset > 0  {
            self.view.frame = CGRect(x: 0.0, y: -offset, width: self.view.frame.width, height: self.view.frame.size.height)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // date picker
    func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "完成", style: .done, target: nil, action: #selector(donePressed))
        
        toolBar.setItems([flexSpace, doneBtn], animated: false)
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "zh-Hant")
        
        birthdateTxt.inputAccessoryView = toolBar
        birthdateTxt.inputView = datePicker
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthdateTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // api
    func signUp(completed: @escaping ApiComplete) {

        Alamofire.request(URL_SINGUP, method: .post, parameters: data, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                
                if let message = json["message"] as? String {
                    if message == "failed" {
                        // get data error message
                        if let errors = json["errors"] as? [String] {
                            //print(errors)
                            let alert = MESSAGE(title: "", message: errors[0])
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                    }
                }
                
                
                print(json)
                
                completed()
        }
        
    }
    
}
