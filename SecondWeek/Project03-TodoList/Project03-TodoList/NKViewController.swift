//
//  NKViewController.swift
//  Project03-TodoList
//
//  Created by Nick Wang on 27/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
typealias sendValue = (_ model : Model) -> Void
class NKViewController: UIViewController {
    var isNew: Bool!
    var editModel: Model!
    //创建一个闭包属性
    var sendValueClsure : sendValue?
    var newTaskDate: String?
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    var tmpBtn: UIButton?
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstBtn.addTarget(self, action: #selector(btnSelected(sender:)), for: .touchUpInside)
        firstBtn.setImage(UIImage(named:"wheel2"), for: .normal)
        firstBtn.tag = 1
        secondBtn.addTarget(self, action: #selector(btnSelected(sender:)), for: .touchUpInside)
        secondBtn.setImage(UIImage(named:"phone2"), for: .normal)
        secondBtn.tag = 2
        thirdBtn.addTarget(self, action: #selector(btnSelected(sender:)), for: .touchUpInside)
        thirdBtn.setImage(UIImage(named:"cart2"), for: .normal)
        thirdBtn.tag = 3
        fourthBtn.addTarget(self, action: #selector(btnSelected(sender:)), for: .touchUpInside)
        fourthBtn.setImage(UIImage(named:"plane2"), for: .normal)
        fourthBtn.tag = 4
        if isNew {
            // 新任务默认选中第一个
            firstBtn.isSelected = true
            tmpBtn = firstBtn
        } else {
            // 修改任务
            let tag = editModel.tag
            switch tag {
            case 1:
                firstBtn.isSelected = true
                tmpBtn = firstBtn
            case 2:
                secondBtn.isSelected = true
                tmpBtn = secondBtn
            case 3:
                thirdBtn.isSelected = true
                tmpBtn = thirdBtn
            case 4:
                fourthBtn.isSelected = true
                tmpBtn = fourthBtn
            default:
                print("无匹配的按钮")
            }
            inputTextField.text = editModel.todoTitle
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let editDate = formatter.date(from: editModel.date)
            datePicker.date = editDate!
        
        }
        
        datePicker.addTarget(self, action: #selector(getDate(datePicker:)), for: .valueChanged)
        doneBtn.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    @objc func getDate(datePicker:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = datePicker.date
        let dateText = formatter.string(from: date)
        newTaskDate = dateText
    }
    @objc func done(){
        var iconName = ""
        switch tmpBtn!.tag {
        case 1:
            iconName = "wheel"
        case 2:
            iconName = "phone"
        case 3:
            iconName = "cart"
        case 4:
            iconName = "plane"
        default:
            print("无匹配的图片")
        }
        if (inputTextField.text?.isEmpty)!{
            let alert = UIAlertController(title: "提示", message: "请输入任务名称", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: {})
        } else if newTaskDate == nil  {
            let alert = UIAlertController(title: "提示", message: "请选择日期", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: {})
        }else {
            let newTask = Model(icon: iconName, todoTitle: inputTextField.text!, date: newTaskDate!, tag: (tmpBtn?.tag)!)
            self.sendValueClsure!(newTask)
            navigationController?.popViewController(animated: true)
        }
        
    }
    @objc func btnSelected(sender: UIButton) {
        if tmpBtn == nil {
            sender.isSelected = true
            tmpBtn = sender
        }else if tmpBtn != nil && tmpBtn == sender{
            sender.isSelected = true
        }else if tmpBtn != nil && tmpBtn != sender {
            tmpBtn?.isSelected = false
            sender.isSelected = true
            tmpBtn = sender
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
