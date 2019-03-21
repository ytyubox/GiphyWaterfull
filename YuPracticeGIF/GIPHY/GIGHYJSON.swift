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
  func getleng(for opt:Option) -> [Int?] {
    let images = data.map{$0.images}
    var re:[String]
    switch opt{
    case .fixHeight: re = images.map{$0.fixed_height.width}
    case .fixWidth: re = images.map{$0.fixed_width.height}
    }
    return re.map{Int($0)}
  }
}

extension GiphyResponse{


  struct GiphyData:Codable {

    var images:Image
    var is_sticker:Int
  }
  struct ImageDetail:Codable {

    ///The publicly-accessible direct URL for this GIF.  ex.  "https://media1.giphy.com/media/cZ7rmKfFYOvYI/200w.gif"
    var    url: String
    ///The width of this GIF in pixels.   ex.   "320"
    var    width: String
    ///The height of this GIF in pixels.    ex.  "200"
    var    height: String
    ///The size of this GIF in bytes.  ex.    "32381"
    var    size: String
    ///The URL for this GIF in .MP4 format.  ex.    "https://media1.giphy.com/media/cZ7rmKfFYOvYI/200w.mp4"
    var    mp4: String
    ///The size in bytes of the .MP4 file corresponding to this GIF.  ex.    "25123"
    var    mp4_size: String
    ///The URL for this GIF in .webp format.   ex.   "https://media1.giphy.com/media/cZ7rmKfFYOvYI/200w.webp"
    var    webp: String
    /////    The size in bytes of the .webp file corresponding to this GIF.  ex.    "12321"
    var    webp_size: String

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
