//
//  GIFWeNeed.swift
//  YuPracticeGIF
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
struct GIFWeNeed {
}


extension UIImageView{
  public func loadGIF(data:Data){
    DispatchQueue.global().async {
      let image = UIImage.gif(data: data)
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }
}
