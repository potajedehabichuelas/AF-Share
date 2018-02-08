//
//  ShareViewController.swift
//  AreaForce Share
//
//  Created by Daniel Bolivar herrera on 05/02/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import MobileCoreServices
import Social

class ShareViewController: SLComposeServiceViewController {
    
    private var linkUrl: String?
    private var linkTitle: String?
    private var linkCategory: AFLinkCategory = AFLinkCategory.videogames

    let networkManager = STNetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeholder = "Copia aqui un link y una descripcion del enlace"
        
        _ = self.isContentValid()
    }
    
    override func isContentValid() -> Bool {
        super.isContentValid()
        
        if self.contentText != nil && self.contentText != "" {
            return true
        }
        if self.linkUrl == nil || self.linkUrl == "" || self.linkTitle == nil {
            return false
        }
        
        return true
    }

    override func didSelectPost() {
        
        self.processLinkAndTitle(text: self.contentText)
        
        guard let link = self.linkUrl, let title = self.linkTitle else { return }

        self.networkManager.shareLink(title: title, urlLink: link, completion: { success in
            if success {
                print("success sending link")
                self.extensionContext?.completeRequest(returningItems: [], completionHandler:nil)
            } else {
                print("error sending link")
            }
        })
    }

    override func configurationItems() -> [Any]! {
        if let deck = SLComposeSheetConfigurationItem() {
            deck.title = "Categoria"
            deck.value = self.linkCategory.string()
            deck.tapHandler = {
                let vc = LinkCategoryTableViewController()
                vc.delegate = self
                self.pushConfigurationViewController(vc)
            }
            return [deck]
        }
        return nil
    }
    
    func findLinksIn(text:String) -> [String] {
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        guard let detect = detector else {
            return []
        }
        var linksArray = [String]()
        let matches = detect.matches(in: text, options: [], range: NSMakeRange(0, text.count))
        for match in matches {
            guard let stringUrl = match.url?.absoluteString else { continue }
            linksArray.append(stringUrl)
        }
        
        return linksArray
    }
    
    func processLinkAndTitle(text: String) {
        guard let link = self.findLinksIn(text: text).first else { return }
        self.linkUrl = link
        
        let title = text.replacingOccurrences(of: link, with: "")
        self.linkTitle = title
        
        //Separate link & title - we grab the link, the rest is the title
        _ = self.isContentValid()
    }
}

extension ShareViewController: ShareSelectCategoryDelegate {
    func selected(category: AFLinkCategory) {
        self.linkCategory = category
        reloadConfigurationItems()
        popConfigurationViewController()
    }
}
