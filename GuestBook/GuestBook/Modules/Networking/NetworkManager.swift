//
//  NetworkManager.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import Foundation
import Alamofire

class NetworkManager {

    static let shared = NetworkManager()

    var user: [String: Any] = [:]
    var token: [String: Any] = [:]

    var path: String { return EndPoints.baseURL + EndPoints.path }

    func doRequestWithHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            ]
        return headers
    }

    func login(withEmail email: String, password: String, block: @escaping (User) -> Void) {
        var parameters = [String : Any]()
        parameters["email"] = email
        parameters["password"] = password
        guard let url = URL(string: self.path + "/auth/login") else { return }
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: self.doRequestWithHeaders()).responseJSON { (response) in
            guard response.error == nil else { return }
            if response.data != nil,
               response.response != nil {
                switch response.result {
                case .success(let value):
                    let responseDict = value as? [String: [String: Any]]
                    guard let result = responseDict?["user"] else { return }
                    self.user.updateValue(result, forKey: "user")
                case .failure(let error):
                    Swift.debugPrint(error)
                    break
                }
            } else {
                return
            }
        }
    }
}
