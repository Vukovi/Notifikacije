//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Vuk on 4/8/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

//ovo sam dodao tako sto sam isao na FILE -> NEW -> TARGET -> NOTIFICATION CONTENT EXTENSION i onda sam kliknuo na ACTIVATE kada je to XCode trazio, a pomocu ovoga mogu da sam podesim dizajn i funkcionalnosti NOTIFIKACIJE 

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    //@IBOutlet var label: UILabel? //OVO NJIHOVO MI NE TREBA
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        //self.label?.text = notification.request.content.body //OVO NJIHOVO MI NE TREBA
        
        guard let attachement = notification.request.content.attachments.first else {
            return //ako guard propadne, skloni se odatle
        }
        
        if attachement.url.startAccessingSecurityScopedResource() {
            let imageData = try? Data(contentsOf: attachement.url)
            if let image = imageData {
                imageView.image = UIImage(data: image)
            }
        }
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "Pesnica" {
            completion(.dismissAndForwardAction)
        } else if response.actionIdentifier == "Otkaži" {
            completion(.dismissAndForwardAction)
        }
    }

}
