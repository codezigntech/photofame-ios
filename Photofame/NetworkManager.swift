//
//  NetworkManager.swift
//  Photofame
//
//  Created by Appit on 6/24/17.
//  Copyright © 2017 Appit. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    
      class func getMediaService(forOffset offset: String, completion: @escaping ([Any]?) -> ()) {
        
        let dict = ["photo_grapher_id": "1", "offset":"\(offset)"] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            
            
            let url = NSURL(string: "http://api.photofame.online/getMedia")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            print(dict)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = json {
                        print(parseJSON)
                        if let code = parseJSON["code"] as? Int {
                            
                            if code == 200 {
                                if let result = parseJSON["result"] as? [Any] {
                                    completion(result)
                                }
                            }
                        }
                    }
                    completion(nil)
                } catch let error as NSError {
                    print(error)
                    completion(nil)
                }        
            }          
            task.resume()
        }
    }

    
    class func getMediaDetails(forId id: Int, completion: @escaping ([String:Any]?) -> ()) {
        
        let dict = ["media_id": id] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            
            
            let url = NSURL(string: "http://api.photofame.online/getMediaDetails")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            print(dict)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = json {
                        print(parseJSON)
                        if let code = parseJSON["code"] as? Int {
                            
                            if code == 200 {
                                if let result = parseJSON["result"] as? [String: Any] {
                                    completion(result)
                                }
                            }
                        }
                    }
                    completion(nil)
                } catch let error as NSError {
                    print(error)
                    completion(nil)
                }
            }
            task.resume()
        }
    }
    

    
    

}
