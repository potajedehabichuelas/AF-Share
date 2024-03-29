//
//  AFNetworkManager.swift
//  Area Force
//
//  Created by Daniel Bolivar herrera on 14/12/16.
//  Copyright © 2016 Sticky Tickets. All rights reserved.
//

import UIKit
import Alamofire

internal class STNetworkManager: NSObject {
    
    //Singleton
    static let sharedInstance = STNetworkManager()
    
    func shareLink(title: String, urlLink: String, category: String, completion: @escaping (Bool) -> Void) {
        
        Alamofire.request(Router.ShareLink(title: title, link: urlLink, category: category)) .responseString { response in
    
            guard response.result.error == nil else {
                print("Error sharing Link to AreaForce")
                print(response.result.error!)
                completion(false)
                return
            }
            print(response.request)
            
            if response.response?.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
            
            debugPrint(request)
        }
    }
}
