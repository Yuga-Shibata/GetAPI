//
//  ViewController.swift
//  GetAPI
//
//  Created by 柴田優河 on 2021/02/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        let url:URL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Imaichi,jp&APPID=8dd4ddd97c9e7819987c47fc89b0a389")!
        let task:URLSessionTask = URLSession.shared.dataTask(with: url) { (data, respons, error) in
            do {
                let Data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                // json内の任意のの値を取り出し
                let top = Data as! Dictionary<String, Any> // トップレベルが配列
                let weather = top["weather"] as! Array<Any>
                let main = weather[0] as! Dictionary<String, Any>
                if let data = main["description"] as? String {
                    DispatchQueue.main.async {
                        if data.contains("sun") {
                            self.weatherText.text = "晴れです"
                        } else if data.contains("cloud") {
                            self.weatherText.text = "曇りです"
                        } else if data.contains("snow") {
                            self.weatherText.text = "雪です"
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

