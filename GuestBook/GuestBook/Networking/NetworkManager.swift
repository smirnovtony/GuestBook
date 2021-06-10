//
//  NetworkManager.swift
//  GuestBook
//
//  Created by Антон Смирнов on 4.05.21.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkManager {

    //MARK: - Variables

    static let shared = NetworkManager()

    var user: [String: Any] = [:]
    var token: [String: Any] = [:]

    var dict: [String: Any] = [:]
    var comment: [Comment] = []
    var loadedComments: [Comment] = []
    var meta: Meta?
    var links: Links?
    
    var path: String { return EndPoints.baseURL + EndPoints.path }

    lazy var userLogged: String = self.loadTestValue()
    lazy var userIsAdmin: Int = self.loadTestInt()

    //MARK: - Structs

    private struct Keys {
        static let tokenData = "tokenData"
        static let isAdmin = "isAdmin"
    }

    //MARK: - Functions

    func saveTestValue() {
        UserDefaults.standard.setValue(userLogged, forKey: "tokenData")
        UserDefaults.standard.setValue(userLogged, forKey: "tokenData")
    }
    func loadTestValue() -> String {
        let value = UserDefaults.standard.value(forKey: "tokenData") as? String
        return value ?? ""
    }
    func loadTestInt() -> Int {
        let value = UserDefaults.standard.value(forKey: "isAdmin") as? Int
        return value ?? 0
    }
    
    func doRequestWithHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        return headers
    }

    func login(withEmail email: String, password: String) {
        var parameters = [String : Any]()
        parameters["email"] = email
        parameters["password"] = password
        guard let url = URL(string: self.path + "/auth/login") else { return }

        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: self.doRequestWithHeaders()).responseJSON { (response) in
            guard response.error == nil else { return }
            if response.data != nil {
                switch response.result {
                case .success(let value):
                    let responseDict = value as? [String: [String: Any]]
                    guard let result = responseDict?["user"] else { return }
                    self.user.updateValue(result, forKey: "user")
                    guard let result = responseDict?["token"] else { return }
                    self.token.updateValue(result, forKey: "token")
                    UserDefaults.standard.set(self.getAccessToken(), forKey: "tokenData")
                    UserDefaults.standard.set(self.isAdmin(), forKey: "isAdmin")
                case .failure(let error):
                    Swift.debugPrint(error)
                    break
                }
            } else {
                return
            }
        }
    }

    func register(withName name: String, email: String, password: String, passwordConfirm: String) {
        var parameters = [String : Any]()
        parameters["name"] = name
        parameters["email"] = email
        parameters["password"] = password
        parameters["password_confirmation"] = passwordConfirm
        guard let url = URL(string: self.path + "/auth/register") else { return }

        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: self.doRequestWithHeaders()).responseJSON { (response) in
            guard response.error == nil else { return }
            if response.data != nil {
                switch response.result {
                case .success:
                    self.login(withEmail: email, password: password)
                case .failure(let error):
                    Swift.debugPrint(error)
                }
            } else {
                return
            }
        }
    }

    func getAccessToken() -> String {
        var accessTokenDict: [String: Any] = [:]
        var accessToken: String = ""
        if let result = token["token"] {
            accessTokenDict = result as! [String: Any]
            if let result = accessTokenDict["access_token"] {
                accessToken = result as! String
            }
        }
        return accessToken
    }
    
    func isAdmin() -> Int {
        var userDict: [String: Any] = [:]
        var userAdmin: Int = 0
        if let result = user["user"] {
            userDict = result as! [String: Any]
            if let result = userDict["is_admin"] {
                userAdmin = result as! Int
            }
        }
        return userAdmin
    }

    func getComments() {
        guard let url = URL(string: (self.path + "/posts")) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as! [String: Any]
                self.dict = resultDict
                let resultData = Mapper<Comment>().mapArray(JSONObject: resultDict["data"])
                self.comment = resultData!
                let resultMeta = Mapper<Meta>().map(JSONObject: resultDict["meta"])
                self.meta = resultMeta
                let resultLinks = Mapper<Links>().map(JSONObject: resultDict["links"])
                self.links = resultLinks
            } else {
                print("ERROR")
            }
        }
    }

    func getCommentsNext(with page: String) {
        guard let url = URL(string: (self.path + "/posts?page=" + page)) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as? [String: Any]
                self.dict = resultDict!
                let result = Mapper<Comment>().mapArray(JSONObject: resultDict?["data"])
                self.loadedComments = result!
                self.comment.append(contentsOf: self.loadedComments)
                let resultM = Mapper<Meta>().map(JSONObject: resultDict?["meta"])
                self.meta = resultM
                print(response)
            } else {
                print("ERROR")
            }
        }
    }
    func addComment(with title: String, message: String, completion: @escaping ((Bool) -> Void)) {
        var parameters = [String : Any]()
        parameters["title"] = title
        parameters["message"] = message
        guard let url = URL(string: (self.path + "/posts")) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as! [String: Any]
                self.dict = resultDict
                let resultData = Mapper<Comment>().mapArray(JSONObject: resultDict["data"])
                self.comment = resultData!
                let resultMeta = Mapper<Meta>().map(JSONObject: resultDict["meta"])
                self.meta = resultMeta
                let resultLinks = Mapper<Links>().map(JSONObject: resultDict["links"])
                self.links = resultLinks
                completion(true)
            } else {
                print("ERROR")
                completion(false)
            }
        }
    }
    func addAnswer(post id: String, message: String, completion: @escaping ((Bool) -> Void)) {
        var parameters = [String : Any]()
        parameters["message"] = message
        guard let url = URL(string: (self.path + "/posts" + "/\(id)/" + "answers")) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as! [String: Any]
                self.dict = resultDict
                let resultData = Mapper<Comment>().mapArray(JSONObject: resultDict["data"])
                self.comment = resultData!
                let resultMeta = Mapper<Meta>().map(JSONObject: resultDict["meta"])
                self.meta = resultMeta
                let resultLinks = Mapper<Links>().map(JSONObject: resultDict["links"])
                self.links = resultLinks
                completion(true)
            } else {
                print("ERROR")
                completion(false)
            }
        }
    }
}

