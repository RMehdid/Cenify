//
//  NetworkLogger.swift
//  Cenify
//
//  Created by Samy Mehdid on 19/12/2023.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {
  //1
  let queue = DispatchQueue(label: "com.raynmore.networklogger")
  //2
  func requestDidFinish(_ request: Request) {
    print(request.description)
  }
  //3
  func request<Value>(
    _ request: DataRequest,
    didParseResponse response: DataResponse<Value, AFError>
  ) {
    guard let data = response.data else {
      return
    }
    if let json = try? JSONSerialization
      .jsonObject(with: data, options: .mutableContainers) {
        print(json)
    }
  }
}
