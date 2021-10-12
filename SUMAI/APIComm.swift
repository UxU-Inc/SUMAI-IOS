//
//  APIComm.swift
//  SUMAI
//
//  Created by 서영규 on 2021/02/19.
//
import Foundation

struct Param : Codable{
    let data : String
    let id : String
    let record : Bool
}

struct Summary : Decodable {
    let summarize: String
}

class APIComm : ObservableObject {
    @Published var loading : Bool = false
    
    func requestSummary(data: String, completion: @escaping (String) -> ()) {
        self.loading.toggle()
        let id : String = ""
        let record : Bool = false
        
        let param = Param(data: data, id: id, record: record)
        let paramData = try! JSONEncoder().encode(param)
        //print(String(data: paramData, encoding: .utf8) ?? "")
        
        let url = URL(string: APIData.summaryUrl)!
        
        var request = URLRequest(url: url, timeoutInterval: 60.0)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.loading.toggle()
                }
                //print("error1: \(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                let object = try? JSONDecoder().decode(Summary.self, from: data!)
                if let jsonObject = object {
                    let summarize = jsonObject.summarize
                    
                    //print(summarize)
                    completion(summarize)
                }
                self.loading.toggle()
            }
        }
        
        task.resume()
    }
}
