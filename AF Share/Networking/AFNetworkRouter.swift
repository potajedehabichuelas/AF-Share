//
//  SENetworkRouter.swift
//  Area Force
//
//  Created by Daniel Bolivar herrera on 14/12/16.
//  Copyright © 2016 Sticky Tickets. All rights reserved.
//

import UIKit

import Foundation
import Alamofire

//Example URL for sharing news to Area Force
//http://areaforce.es/bd/shared.php?str=Titulo%20to%20bonico&url=http://pruebasecreta.com

enum AFUrlConstants {
    //Url & constants required for the endpoints
    static let base_Url: String = ""
    
    static let share_Link_Path: String = ""
}

enum AFLinkCategory {
    
    case videogames
    case cinema
    case eSports
    
   static let allValues = [videogames, cinema, eSports]
    
    func string() -> String {
        
        switch self {
            
        case .videogames:
            return "Videojuegos"
            
        case .cinema:
            return "Cine"
            
        case .eSports:
            return "e-Sports"
        }
    }
    
    func value() -> String {
        
        switch self {
            
        case .videogames:
            return "1"
            
        case .cinema:
            return "2"
            
        case .eSports:
            return "3"
        }
        
    }
}

enum AFshareEndpointConstants {
    static let title = "str"
    static let linkUrl = "url"
    static let category = "section"
}

enum Router: URLRequestConvertible {
    static let baseURLString = AFUrlConstants.base_Url
    
    // Values
    case ShareLink(title:String, link: String, category: String)

    // Methods
    var method: Alamofire.HTTPMethod {
        switch self {
            
        case .ShareLink:
            return .post
        }
    }
    
    // Paths
    var path: String {
        switch self {
            case .ShareLink:
                return AFUrlConstants.share_Link_Path
        }
    }
    
    // endpoint parameters
    var parameters: Parameters? {
        switch self {
        
        case .ShareLink(let params):
            
            var parameters: [String : Any] = Dictionary()
            
            parameters[AFshareEndpointConstants.title] = params.title
            parameters[AFshareEndpointConstants.linkUrl] = params.link
            parameters[AFshareEndpointConstants.category] = params.category
            
            return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: Router.baseURLString+self.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
            case .ShareLink:
                return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: self.parameters)
        }
    }
}
