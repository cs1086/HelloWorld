//
//  DataBaseSample.swift
//  helloWorld
//
//  Created by SJ on 2022/7/5.
//

import UIKit
import RealmSwift
struct SetOrder{
    var setName:String?
    var setPrice:String?
    var setId:String=UUID().uuidString
    init(setName:String,setPrice:String,setId:String){
        self.setName=setName
        self.setPrice=setPrice
        self.setId=setId
    }
}
class DBViewController: UIViewController{
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var orderPrice: UITextField!
    @IBOutlet weak var orderName: UITextField!
    let realm = try! Realm()
    var orders:[SetOrder]?=[]
    override func viewDidLoad() {
        print("####viewDidLoad")
        orderTable.dataSource = self
        orderTable.delegate=self
        refresh()
    }
    
    @IBAction func save(_ sender: UIButton) {
        print("####save")
        
        let order=Order()
        order.name=orderName.text!
        if let price = Int(orderPrice.text!){
            order.price=price
        }
//        print("fileURL: \(realm.configuration.fileURL!)")
        try! realm.write{realm.add(order)}
        refresh()
    }
    func refresh(){
        orders=[]
        let object=realm.objects(Order.self)
        guard object.count>0 else{print("資料庫吳資料");return}
        print("####共有\(object.count)筆資料")
        for i in 0..<object.count{
            orders?.append(SetOrder(setName: object[i].name, setPrice: String(object[i].price), setId: object[i].id))
        }
        orderTable.reloadData()

    }
}
extension DBViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("使用者點選了 \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderData", for: indexPath)
//        cell.textLabel?.text = "訂單：\(orders?[indexPath.row].setName),價格:\(orders?[indexPath.row].setPrice)"
      
        cell.textLabel?.text = orders?[indexPath.row].setName
        return cell
    }
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int)->Int{
        return orders!.count
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //刪除訂單
        let orderId = NSPredicate(format: "id = %@ ", self.orders![indexPath.row].setId)
        //左滑刪除
        let deleteOrders = realm.objects(Order.self).filter(orderId)
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") {[self] (action, sourceView, complete) in
            self.orders!.remove(at: indexPath.row)
            self.orderTable.deleteRows(at: [indexPath], with: .top)
            try! self.realm.write {realm.delete(deleteOrders)}
            complete(true)
            }
        deleteAction.image = UIImage(systemName: "trash")//在按鈕上新增圖示
        
        //修改訂單
                let modifyAction = UIContextualAction(style: .normal, title: "修改訂單") { (action, sourceView, complete) in
                    //呼叫提示框
                    func createAlert(alertTitle: String, alertMessage: String, actionTitle: String, cancleTitle: String, indexPath: IndexPath?)
                    {
                        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                        let cancleAction = UIAlertAction(title: cancleTitle, style: .cancel, handler: nil)
                        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: {
                            (action: UIAlertAction!) -> Void in
                            let modify: Order = Order()
                            let text0 = alert.textFields?[0].text
                            let text1 = alert.textFields?[1].text
                            modify.id = self.orders![indexPath!.row].setId
                            modify.name = text0!
                            modify.price = Int(text1!)!
                            try! self.realm.write {self.realm.add(modify, update: .all)}
                            self.refresh()
                        })
                        alert.addTextField { (titleTF) in
                            titleTF.placeholder = "訂單名稱"
                        }
                        alert.addTextField { (subtitleTF) in
                            subtitleTF.placeholder = "訂單價錢"
                        }
                        alert.addAction(okAction)
                        alert.addAction(cancleAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    createAlert(alertTitle: "修改", alertMessage: "", actionTitle: "確認", cancleTitle: "取消", indexPath: indexPath)
                    complete(true)
                }
                modifyAction.image = UIImage(systemName: "square.and.pencil")
                modifyAction.backgroundColor = UIColor.systemYellow
        //整合兩顆按鈕
        let leftSwipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,modifyAction])
        return leftSwipeConfiguration
    }
}
