//
//  ViewController.swift
//  helloWorld
//
//  Created by SJ on 2022/6/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sign_up: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        sign_up.setTitle("登入", for:.normal)
        //view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }

    @IBAction func click(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Welcome to My First App", message: "Hello World", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sign_up_button(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_sign_up", sender: self)
    }
    
    @IBAction func log_in_button(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_index", sender: self)
    }
    @IBAction func db_demo_button(_ sender: UIButton) {
        performSegue(withIdentifier: "db_demo", sender: self)
    }
    @IBAction func segue_ui_picker_button(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_ui_picker", sender: self)
    }
    @IBAction func segue_http_button(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_http", sender: self)
    }
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        print("我回來了\(sourceViewController.title)")
    }
}

