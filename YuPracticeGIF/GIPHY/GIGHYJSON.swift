//
//  GIGHYJSON.swift
//  YuPracticeGIF
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Foundation
struct GiphyResponse:Codable {


  var meta:Meta
  var data:[GiphyData]
  var pagination:Pagination

  init?(from data:Data) {
    var new :GiphyResponse
    do {
      new = try JSONDecoder().decode(GiphyResponse.self, from: data)
    }catch{
      fatalError(error.localizedDescription)
      return nil
    }
    self = new
  }
}

extension GiphyResponse{

  enum Option{
    case fixWidth
    case fixHeight
  }

  func getURL(for opt:Option)->[URL]{
    let images = data.map{$0.images}
    var re:[String]
    switch opt {
    case .fixHeight:     re = images.map{$0.fixed_height.url}
    case .fixWidth:      re = images.map{$0.fixed_height.url}
    }
    return re.compactMap{URL(string: $0)}
  }
}

extension GiphyResponse{


  struct GiphyData:Codable {

    var images:Image
    var is_sticker:Int
  }
  struct ImageDetail:Codable {
    var url:String
  }
  struct Fixed_width:Codable {
    var url:String
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

  struct Image:Codable {
    var fixed_height:ImageDetail
    var fixed_width:ImageDetail
  }
}
