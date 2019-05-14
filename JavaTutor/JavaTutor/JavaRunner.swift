//
//  JavaRunner.swift
//  JavaTutor
//
//  Created by Sam Carlin on 4/11/19.
//  Copyright © 2019 Logan Stahl. All rights reserved.
//

import Foundation

public class JavaRunner {
    private static let endpoint = "http://api.paiza.io:80/runners/"
    
    public static func Exec(code: String, input: String, completion: @escaping (String) -> Void) {
        var urlC = URLComponents(string: endpoint + "create")!
        
        urlC.queryItems = [
            URLQueryItem(name: "source_code", value: code),
            URLQueryItem(name: "input", value: input),
            URLQueryItem(name: "language", value: "java"),
            URLQueryItem(name: "api_key", value: "guest")
        ]
        
        let url = URL(string: urlC.string!.replacingOccurrences(of: ";", with: "%3B").replacingOccurrences(of: "+", with: "%2B"))
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any>
                    
                    // Wait and get results
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                        GetResults(id: (json!["id"]! as? String)!, completion: completion)
                    })
                    
                    return
                }
                catch {
                    // Do nothing
                }
            }
            
            completion("Network error, try again later")
        })
        
        task.resume()
    }
    
    private static func GetResults(id: String, completion: @escaping (String) -> Void) {
        var url = URLComponents(string: endpoint + "get_details")!
        
        url.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "api_key", value: "guest")
        ]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
                    
                    if let out = json["stdout"] as? String {
                        completion(out)
                    } else {
                        completion(json["build_stderr"] as! String)
                    }
                    
                    return
                }
                catch {
                    // Do nothing
                }
            }
            
            completion("Network error, try again later")
        })
        
        task.resume()
    }
}

