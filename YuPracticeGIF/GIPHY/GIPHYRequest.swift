//
//  GIPHYRequest.swift
//  YuPracticeGIF
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Foundation

let APIKEY = "&api_key=" +  "1Wg45GsQ5FZL1lDqhbWEfUhF1ZdZDiny"

let HOST = "https://" + "api.giphy.com"
enum Path:String{
  case trending = "/v1/gifs/trending?"
  case search =  "/v1/gifs/search?"

  var method:String {
    switch self {
    case .trending,.search:
      return "GET"
    default:
      return ""
    }
  }
}

class Giphy{
  func loadGiphyTread(completion: @escaping ((Result<Data>)->Void)) {
    let purpose = Path.trending
    let string = HOST + purpose.rawValue + APIKEY
    guard let getURL =  URL(string: string) else { return  }
    URLSession.shared.dataTask(with: getURL) { (data, response, error) in
      if let error = error {
        DispatchQueue.main.async {completion(Result.error(error))}
        return
      }
      guard
        let _ = response as? HTTPURLResponse,
        let data = data else {
          DispatchQueue.main.async {completion(Result.error(Error.unknownAPIResponse))}
          return
      }
      DispatchQueue.main.async{completion(Result.results(data))}
    }.resume()
  }



}


extension Giphy{
  enum Error: Swift.Error {
    case unknownAPIResponse
    case generic
  }
}
