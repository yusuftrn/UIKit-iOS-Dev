//
//  Webservice.swift
//  CryptoMMVM
//
//  Created by Yusuf Turan on 7.07.2021.
//

import Foundation

class Webservice {
  func downloadData(url: URL, completion: @escaping ([Currency]?) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, response, err) in
      if let err = err {
        print(err.localizedDescription)
      } else if let data = data {
        let currencies = try? JSONDecoder().decode([Currency].self, from: data)
        DispatchQueue.main.async {
          completion(currencies)
        }
      }
    }.resume()
  }
}
