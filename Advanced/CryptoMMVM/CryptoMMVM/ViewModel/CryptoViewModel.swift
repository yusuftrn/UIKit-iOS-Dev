//
//  CryptoViewModel.swift
//  CryptoMMVM
//
//  Created by Yusuf Turan on 7.07.2021.
//

import Foundation

struct CryptoListViewModel {
  let currenyList: [Currency]
  
  func numberOfRowsInSection() -> Int {
    return self.currenyList.count
  }
  
  func cryptoAtIndex(_ index: Int) -> CryptoViewModel {
    let crypto = self.currenyList[index]
    return CryptoViewModel(cryptoCurrency: crypto)
  }
}

struct CryptoViewModel {
  let cryptoCurrency: Currency
  
  var name: String {
    return self.cryptoCurrency.currency
  }
  
  var price: String {
    return self.cryptoCurrency.price
  }
}
