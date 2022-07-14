//
//  IndexViewController.swift
//  helloWorld
//
//  Created by SJ on 2022/7/1.
//

import UIKit

class IndexViewController: UIViewController{
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    let dataList=["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setTitleColor(UIColor.red, for: [])
        backButton.layer.borderColor = UIColor.red.cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 10
        myTableView.dataSource = self
    }
}
extension IndexViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("使用者點選了 \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MyTableViewCell", owner: self, options: nil)?.first as! MyTableViewCell
        cell.lbl.text = dataList[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableCell", for: indexPath)
        //cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int)->Int{
        return dataList.count
    }
}
