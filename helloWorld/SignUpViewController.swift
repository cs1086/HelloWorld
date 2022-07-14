//
//  SignUpViewController.swift
//  helloWorld
//
//  Created by SJ on 2022/7/1.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var paletteImage: UIImageView!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var rTextField: UITextField!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var gTextField: UITextField!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var bTextField: UITextField!
    

    @IBAction func textToSlider(_ sender: UITextField) {
        if let rTextField=rTextField.text{
            if let rTextField = Int(rTextField){
                rSlider.setValue(Float(rTextField), animated: true)
            }
        }
        if let gTextField=gTextField.text{
            if let gTextField = Int(gTextField){
                gSlider.setValue(Float(gTextField), animated: true)
            }
        }
        if let bTextField=bTextField.text{
            if let bTextField = Int(bTextField){
                bSlider.setValue(Float(bTextField), animated: true)
            }
        }
        paletteImage.backgroundColor = UIColor(
                    red: CGFloat((rSlider.value)/255),
                    green: CGFloat((gSlider.value)/255),
                    blue: CGFloat((bSlider.value)/255),
                    alpha: 1
                )
    }
    
    @IBAction func SliderChange(_ sender: Any) {
//        print("red=\(rSlider.value)")
//        print("green=\(gSlider.value)")
//        print("blue=\(bSlider.value)")
        rTextField.text = "\(Int(rSlider.value))"
        gTextField.text = "\(Int(gSlider.value))"
        bTextField.text = "\(Int(bSlider.value))"
        paletteImage.backgroundColor = UIColor(
                    red: CGFloat((rSlider.value)/255),
                    green: CGFloat((gSlider.value)/255),
                    blue: CGFloat((bSlider.value)/255),
                    alpha: 1
                )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rTextField.text = "\(Int(rSlider.value))"
        gTextField.text = "\(Int(gSlider.value))"
        bTextField.text = "\(Int(bSlider.value))"
        paletteImage.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
