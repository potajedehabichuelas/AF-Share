//
//  ShareLinkViewController.swift
//  AF Share
//
//  Created by Daniel Bolivar herrera on 05/02/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import RMessage
import MBProgressHUD

class ShareLinkViewController: UIViewController {

    @IBOutlet weak var linkTitleTextField: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    let networkManager = STNetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendLinkButton(_ sender: Any) {
        
        guard let linkUrl = self.linkTextField.text, linkUrl != "" else {
            RMessage.showNotification(withTitle: "No has introducido ningun enlace", subtitle: "", type: .error, customTypeName: "", callback: nil)
            return
        }
        
        guard let linkTitle = self.linkTitleTextField.text, linkTitle != "" else {
            RMessage.showNotification(withTitle: "El enlace no tiene titulo", subtitle: "", type: .error, customTypeName: "", callback: nil)
            return
        }
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true);
        loadingNotification.mode = .indeterminate
        loadingNotification.label.text = "Enviando Enlace"
        
        
        self.networkManager.shareLink(title: linkTitle, urlLink: linkUrl, category: AFLinkCategory.videogames.value(), completion: { success in
            if success {
                RMessage.showNotification(withTitle: "Enlace enviado con exito", subtitle: "", type: .success, customTypeName: "", callback: nil)
            } else {
                RMessage.showNotification(withTitle: "Ups, el enlace no pudo ser enviado", subtitle: "", type: .error, customTypeName: "", callback: nil)
            }
            //Dismiss notification
            loadingNotification.hide(animated: true)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
