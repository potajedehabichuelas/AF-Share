//
//  AFStorage.swift
//  AF Share
//
//  Created by Daniel Bolivar herrera on 05/02/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

private let AFSharegroupIdentifier = "group.com.AreaForce.AF-Share"

class AFStorage: NSObject {
    //Singleton
    static let sharedInstance = AFStorage()
    
    func getContainerLinkUrl() -> String? {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: AFSharegroupIdentifier)?.path
    }
}
