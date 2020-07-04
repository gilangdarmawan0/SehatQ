//
//  ApiConf.swift
//  SehatQ
//
//  Created by Gilang Darmawan on 23/04/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import Foundation
import UIKit
/*
 Enum uses in API
 */
enum Result<Value: Decodable> {
    case success(Value)
    case failure(Value?)
}

typealias Handler = (Result<Data>) -> Void

enum NetworkError: Error {
    case nullData
}

public enum Method {
    case delete
    case get
    case head
    case post
    case put
    case connect
    case options
    case trace
    case patch
    case other(method: String)
}

enum NetworkingError: String, LocalizedError {
    case jsonError = "JSON error"
    case other
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}

extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "DELETE":
            self = .delete
        case "GET":
            self = .get
        case "HEAD":
            self = .head
        case "POST":
            self = .post
        case "PUT":
            self = .put
        case "CONNECT":
            self = .connect
        case "OPTIONS":
            self = .options
        case "TRACE":
            self = .trace
        case "PATCH":
            self = .patch
        default:
            self = .other(method: method)
        }
    }
}

extension Method: CustomStringConvertible {
    public var description: String {
        switch self {
        case .delete:            return "DELETE"
        case .get:               return "GET"
        case .head:              return "HEAD"
        case .post:              return "POST"
        case .put:               return "PUT"
        case .connect:           return "CONNECT"
        case .options:           return "OPTIONS"
        case .trace:             return "TRACE"
        case .patch:             return "PATCH"
        case .other(let method): return method.uppercased()
        }
    }
}

protocol Requestable {}

extension Requestable {
    internal func request(method: Method, url: String, params: [String: Any]? = nil, token: String? = nil, callback: @escaping Handler) {
        guard let url = URL(string: url) else {
            return
        }
        var request = URLRequest(url: url)
        if let params = params {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let imageData = params["imageData"] as? Data
            if ((imageData) != nil){
            }else{
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
        }
        request.httpMethod = method.description
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.ENUS.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptLangauge.rawValue)
        if (token != nil) {
            request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        }
                
         let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    callback(.failure(data))
                } else if let httpResponse = response as? HTTPURLResponse {
                    debugPrint("DEBUGGER ----------------")
                    debugPrint("Endpoint - \(url)")
                    debugPrint("Status Code - \(httpResponse.statusCode)")
                    do {
                        if (data != nil) {
                            if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any],
                                let body = json["data"] as? [String: Any] {
                                debugPrint("Response Data - ")
                                debugPrint(body)
                            }
                            
                            if let json2 = try JSONSerialization.jsonObject(with: data!) as? [String: Any],
                                let body = json2["errors"] as? [String: Any] {
                                debugPrint("Response Errors - ")
                                debugPrint(body)
                            }
                        }
                    } catch {
                        debugPrint("Error while parsing response")
                    }
                    debugPrint("-----------------------------------")
                    if httpResponse.statusCode == 200 {
                        callback(.success(data!))
                    } else if httpResponse.statusCode == 401 {
                        callback(.failure(data!))
                    } else if httpResponse.statusCode == 201 {
                        callback(.success(data!))
                    } else if httpResponse.statusCode == 400 {
                        callback(.failure(data!))
                    } else {
                        callback(.failure(data!))
                    }
                }
            }
        })
        task.resume()
    }
}

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
        var miliseconds = (self * 10).rounded() * 10
        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d.%.f", minutes, seconds, miliseconds)
    }
}
