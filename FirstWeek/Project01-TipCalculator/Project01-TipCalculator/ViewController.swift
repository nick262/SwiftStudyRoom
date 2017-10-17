//
//  ViewController.swift
//  Project01-TipCalculator
//
//  Created by Nick Wang on 17/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var rateSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        amountField.inputAccessoryView = addKeboardToolbar()
        self.rateSlider.addTarget(self, action: #selector(rateChanged(slider:)), for: .valueChanged)
    }
    // 当滑块滑动时调用以下方法
    @objc func rateChanged(slider: UISlider)  {
        let rate = Int(slider.value)
        tipRateLabel.text = "Tip: \(rate)%"
        let amount = (amountField.text! as NSString).floatValue
        tipAmountLabel.text = "$" + String(format:"%.2f",amount * Float(rate) / 100.0)
        totalAmountLabel.text = "$" + String(format:"%.2f",amount * Float(rate) / 100.0 + amount)
    }
    // 给数字键盘上方添加工具按扭
    func addKeboardToolbar() -> UIToolbar {
        let toolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        toolbar.tintColor = UIColor.blue
        toolbar.backgroundColor = UIColor.lightGray
        // 添加按钮前的空白区域
        let space = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // 添加“完成”按钮
        let bar = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(textFieldDone))
        toolbar.items = [space,bar]
        return toolbar
    }
    @objc func textFieldDone() {
        let amount = (amountField.text! as NSString).floatValue
        let rate = Int(rateSlider.value)
        tipAmountLabel.text = "$" + String(format:"%.2f",amount * Float(rate) / 100.0)
        totalAmountLabel.text = "$" + String(format:"%.2f",amount * Float(rate) / 100.0 + amount)
        self.view.endEditing(true)
    }
    deinit {
        print("TipCalculatorVC deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

