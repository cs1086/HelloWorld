//
//  HTTPController.swift
//  helloWorld
//
//  Created by SJ on 2022/7/6.
//

import UIKit
class HTTPController: UIViewController {
    @IBOutlet weak var selectLocationDate: UIButton!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var relax: UILabel!
    @IBOutlet weak var rainRate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var parameterName: UILabel!
    let locationList=["台北市","新北市","桃園市","台中市","台南市","高雄市"]
    let timeList=["2022-07-11 12:00:00","2022-07-11 18:00:00","2022-07-12 06:00:00"]
    var selectLocation="台中市"
    var selectDate=0
    let locationPickerView=UIPickerView(frame:CGRect(x:0,y:50,width:270,height:150))
    let datePickerView=UIPickerView(frame:CGRect(x:0,y:50,width: 270,height:150))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationPickerView.dataSource=self
        locationPickerView.delegate=self
        datePickerView.dataSource=self
        datePickerView.delegate=self
        var semaphore = DispatchSemaphore (value: 0)
        loadWeather()
//
//        var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-9917DEB8-39BD-4791-8349-BF15F9B15515&format=JSON")!,timeoutInterval: Double.infinity)
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          guard let data = data else {
//            print(String(describing: error))
//            semaphore.signal()
//            return
//          }
//          print(String(data: data, encoding: .utf8)!)
//          semaphore.signal()
//        }
//
//        task.resume()
//        semaphore.wait()
    }
    
    @IBAction func locationAction(_ sender: UIButton) {
        locationView()
    }
    
    func locationView(){
        let alertView=UIAlertController(title: "選擇地點", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)//message提高dialog高度
        let cancelAction=UIAlertAction(title: "取消",style: .cancel,handler: nil)
        let okAction=UIAlertAction(title: "確認",style: .default,handler: {
            _ in
            self.loadWeather()
            self.timeView()
        })
        alertView.view.addSubview(locationPickerView)
        alertView.addAction(cancelAction)
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
    func timeView(){
        let alertView = UIAlertController(
                    title: "選擇時間",
                    message: "\n\n\n\n\n\n\n\n\n",
                    preferredStyle: .alert
                )
                let cancelAction = UIAlertAction(
                    title: "取消",
                    style: .cancel,
                    handler: nil
                )
                let okAction = UIAlertAction(
                    title: "確認",
                    style: .default,
                    handler: {_ in self.loadWeather()}
                )
                alertView.view.addSubview(datePickerView)
                alertView.addAction(cancelAction)
                alertView.addAction(okAction)
                present(alertView, animated: true, completion: nil)
    }
    func loadWeather(){
        print("訊息1：")
            let url =  "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-9917DEB8-39BD-4791-8349-BF15F9B15515&format=JSON"
            let newUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            var request = URLRequest(url: URL(string: newUrl)!,timeoutInterval: Double.infinity)
        print("訊息2：\(request)")
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                let decoder = JSONDecoder()
                print("訊息3")
                do{
                    if let data = data, let weather = try decoder.decode(Weather?.self, from: data){
                        print("訊息4：\(weather)")
                        DispatchQueue.main.sync {
                            self.location.text = weather.records.location[0]?.locationName
                            
                            if let maxTemp=weather.records.location[0]?.weatherElement[4].time[0].parameter.parameterName,let tempUnit = weather.records.location[0]?.weatherElement[4].time[0].parameter.parameterUnit{
                                self.maxTemp.text="\(maxTemp)°\(tempUnit)"
                            }
                            
                            if let minTemp = weather.records.location[0]?.weatherElement[2].time[0].parameter.parameterName,let tempUnit = weather.records.location[0]?.weatherElement[2].time[0].parameter.parameterUnit{
                                self.minTemp.text="\(minTemp)°\(tempUnit)"
                            }
                            if let relax=weather.records.location[0]?.weatherElement[3].time[0].parameter.parameterName{
                                self.relax.text = relax
                            }
                            if let rainRate = weather.records.location[0]?.weatherElement[1].time[0].parameter.parameterName{
                                self.rainRate.text = "\(rainRate)%"
                            }
                            if let startDate = weather.records.location[0]?.weatherElement[0].time[0].startTime{
                                self.startDate.text = startDate
                            }
                            if let endDate = weather.records.location[0]?.weatherElement[0].time[0].endTime{
                                self.endDate.text = endDate
                            }
                            if let parameterName = weather.records.location[0]?.weatherElement[0].time[0].parameter.parameterName{
                                self.parameterName.text = parameterName
                            }
                        }
                    }else {
                        print("error")
                    }
                }catch{
                    print("跑到catch")
                    print(error)
                }
            }
            task.resume()
        }
}
extension HTTPController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == locationPickerView {
            return locationList.count
        }
        if pickerView == datePickerView {
            return timeList.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == locationPickerView {
            return locationList[row]
        }
        if pickerView == datePickerView {
            return timeList[row]
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == locationPickerView {
            selectLocation = locationList[row]
        }
        if pickerView == datePickerView {
            selectDate = row
        }
    }
}
