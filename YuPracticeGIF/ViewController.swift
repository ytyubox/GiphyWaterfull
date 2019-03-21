//
//  ViewController.swift
//  YuPracticeGIF
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

  let giphy = Giphy()

  override func viewDidLoad() {
    super.viewDidLoad()

  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    giphy.loadGiphyTread { (result) in
      switch result{
      case .error(let error):
        print("Error loading:" + error.localizedDescription)
      case .results(let data):
        print(data.prettyPrintedJSONString ?? "error")
        let res = GiphyResponse(from: data)
        print(res)
      }
    }
  }


}
enum Option{
  case width
  case height
}

struct GiphyResponse:Codable {
  var meta:Meta
//  var data:GiphyData
  var pagination:Pagination


  init?(from data:Data) {
    var new :GiphyResponse
    do {
        new = try JSONDecoder().decode(GiphyResponse.self, from: data)
    }catch{return nil;fatalError(error.localizedDescription)}
    self = new

  }
}
struct GiphyData:Codable {
  var fixed_height:[Fixed_height]
  var fixed_width:[Fixed_width]

  struct Fixed_height:Codable {
    var url:String
  }
  struct Fixed_width:Codable {
    var url:String
  }
}
struct Meta:Codable {
  var status:Int
  var msg:String
  var response_id:String
}

struct Pagination:Codable {
  ///  Position in pagination.
 var  offset: Int
  ///  Total number of items available.
 var  total_count: Int
  ///  Total number of items returned.
 var  count: Int
}
