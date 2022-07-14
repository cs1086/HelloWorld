//
//  UIPickController.swift
//  helloWorld
//
//  Created by SJ on 2022/7/5.
//

import UIKit

class UIPickController: UIViewController {
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var uiPiker: UIPickerView!
    let week = ["星期一","星期二","星期三","星期四","星期五","星期六","星期日"]
    override func viewDidLoad() {
        super.viewDidLoad()
        uiPiker.delegate=self
        uiPiker.dataSource=self
    }
}
extension UIPickController: UIPickerViewDelegate, UIPickerViewDataSource {
    // UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5    }
    // UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return week.count
    }
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return week[row]
    }
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLabel.text = week[row]
    }

}
