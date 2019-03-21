import Foundation

enum Result<ResultType> {
  case results(ResultType)
  case error(Error)
}

extension String{
  var searchURL:URL?{
    guard let secapedTerm = self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {return nil}
    let URLString = HOST + Path.search.rawValue + "q=" + secapedTerm + "&api_key=" + APIKEY
    return URL(string: URLString)
  }

}
extension Data {
  var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
      let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

    return prettyPrintedString
  }
}
