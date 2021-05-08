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

    // mapping
    var dict: [String: Any] = [:]
    var comment: [Comment] = []
    var loadedComments: [Comment] = []
    var meta: Meta?
    var links: Links?

    lazy var userLogged: String = self.loadTestValue()

    var path: String { return EndPoints.baseURL + EndPoints.path }
    //MARK: - Struct

    private struct Keys {
        static let tokenData = "tokenData"
    }

    //MARK: - Functions

    func saveTestValue() {
        UserDefaults.standard.setValue(userLogged, forKey: "tokenData")
    }
    func loadTestValue() -> String {
        let value = UserDefaults.standard.value(forKey: "tokenData") as? String
        return value ?? ""
    }
    //MARK: - Functions
    
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

        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: self.doRequestWithHeaders()).responseJSON { (response) in
            guard response.error == nil else { return }
            if response.data != nil {
                switch response.result {
                case .success(let value):
                    let responseDict = value as? [String: [String: Any]]
                    guard let result = responseDict?["user"] else { return }
                    self.user.updateValue(result, forKey: "user")
//                    print("userrr      \(result)")
                    guard let result = responseDict?["token"] else { return }
                    self.token.updateValue(result, forKey: "token")
//                    print("tokennnnn      \(result)")
                    UserDefaults.standard.set(self.getAccessToken(), forKey: "tokenData")
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

        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: self.doRequestWithHeaders()).responseJSON { (response) in
            guard response.error == nil else { return }
            if response.data != nil {
                switch response.result {
                case .success(let value):
                    self.login(withEmail: email, password: password)
//                    Swift.debugPrint(value)
                case .failure(let error):
//                    Swift.debugPrint(error)
                    break
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
//        print("dbfydfh      \(accessToken)")
        return accessToken
    }

    func getComments() {
        guard let url = URL(string: (self.path + "/posts")) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as! [String: Any]
                self.dict = resultDict
                let result = Mapper<Comment>().mapArray(JSONObject: resultDict["data"])
                self.comment = result!
//                print("NetworkManager   \(self.comment)")
            } else {
                print("ERROR")
            }
        }
    }
    func getCommentsNext(with page: String) {
//        guard let page = pagecounter else { return }
        guard let url = URL(string: (self.path + "/posts?page=" + page)) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as! [String: Any]
//                print("NetworkManager   \(resultDict)")
                self.dict = resultDict
                let result = Mapper<Comment>().mapArray(JSONObject: resultDict["data"])
                self.loadedComments = result!
                self.comment.append(contentsOf: self.loadedComments)
//                print(self.comment.count)
//                print(NetworkManager.shared.links?.next)
            } else {
                print("ERROR")
            }
        }
    }

    func getMeta() {
        guard let url = URL(string: (self.path + "/posts")) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as? [String: Any]
//                let result = Mapper<Meta>().mapDictionary(JSONObject: resultDict["meta"])
                let result = Mapper<Meta>().map(JSONObject: resultDict?["meta"])
                self.meta = result
//                print("NetworkManager   \(resultDict)")
            } else {
                print("ERROR")
            }
        }
    }

    func getlinks() {
        guard let url = URL(string: (self.path + "/posts")) else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(UserDefaults.standard.value(forKey: "tokenData") ?? getAccessToken())"]

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let resultDict = response.value as? [String: Any]
                let result = Mapper<Links>().map(JSONObject: resultDict?["links"])
                self.links = result
//                print("NetworkManager   \(self.links)")
            } else {
                print("ERROR")
            }
        }
    }
    func getPosts() {
//        guard let url = URL(string: (self.path + "/posts")) else { return }
//        let headers: HTTPHeaders = ["Authorization": "Bearer \(getAccessToken())"]
//
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
//            guard response.error == nil else { return }
//            if response.data != nil, response.response != nil {
//                switch response.result {
//                case .success(let value):
//                    let responseDict = value as? [String: Any]
//
//                    guard let resultdata = responseDict?["data"] else { return }
//                    self.dataArray = resultdata
//
//                    guard let resultlinks = responseDict?["links"] else { return }
//                    self.linksDict = resultlinks as! [String: Any]
//                    self.links = Links(first: self.linksDict["first"] as? String,
//                                       next: self.linksDict["next"] as? String,
//                                       prev: self.linksDict["prev"] as? String ,
//                                       last: self.linksDict["last"] as? String)
//
//                    guard let resultmeta = responseDict?["meta"] else { return }
//                    self.metaDict = resultmeta as! [String : Any]
////                    print("!!!!!''''''''\(String(describing: self.metaDict))")
//
//                case .failure(let error):
//                    Swift.debugPrint(error)
//                    break
//                }
//            }
//        }
    }
}



