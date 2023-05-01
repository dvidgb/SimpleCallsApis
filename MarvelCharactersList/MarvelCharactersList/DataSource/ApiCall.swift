//
//  ApiCall.swift
//  MarvelCharactersList
//
//  Created by David Bueno Castro on 1/5/23.
//

import Foundation
import CryptoKit

class MarvelApi{
    static let publicKey = "6eefffa8f122023db356ef72b70a7615"
    static let privateKey = "eba06758646b381fa59f2588bcede278f9cee20b"
    
    enum Endpoint{
        static let base = "https://gateway.marvel.com:443/v1/public/characters"
        static let apiKeyParam = "?apikey=\(publicKey)"
        
        case filterHeros
        
        var stringValue:String{
            switch self {
            case .filterHeros:
                return Endpoint.base + Endpoint.apiKeyParam + hashParam
            }
        }
        
        var hashParam: String {
            let timestamp = Date().currentTimeInMillis()
            return "&ts=\(timestamp)&hash=" + ("\(timestamp)\(privateKey)\(publicKey)".md5Value)
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
    class func filterHeroes(completion: @escaping ([String], Error?) -> Void) {
        print("url: " + Endpoint.filterHeros.stringValue)
        let task = URLSession.shared.dataTask(with: Endpoint.filterHeros.url) { (data, response, error) in
            guard let data = data else {
                completion([],error)
                print("guard statement successful")
                return
            }
            print("api call successful")
            do{
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObject)
                print("json parsing successful")
            }
            catch{
                print("json parsing field")
                completion([], nil)
                print(error)
            }
            
        }
        task.resume()
        
    }
}

extension Date {
    func currentTimeInMillis() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}

extension String {
var md5Value: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
