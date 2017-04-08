//
//  ViewController.swift
//  Notifikacije
//
//  Created by Vuk on 4/7/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //po ucitavanju prvo hocu da aplikacija trazi dozvolu za notifikacije
        UNUserNotificationCenter.current().requestAuthorization(options: [UNAuthorizationOptions.alert, UNAuthorizationOptions.badge, UNAuthorizationOptions.sound]) { (dozvoljeno, error) in
            if dozvoljeno {
                print("Notifikacije dozvoljene!")
            } else {
                print(error!.localizedDescription)
            }
        }
    }


    @IBAction func dugmeZaNotifikacijuPritisnuto(_ sender: UIButton) {
        pripremaNotifikacije(zaVremeUSekundama: 5) { (uspesnoObavljeno) in
            //mogu da postavim da ovo radi npr jednom nedeljno
            if uspesnoObavljeno {
                print("Uspesno Notifikovano!")
            } else {
                print("Greska u notifikovanju!")
            }
        }
    }
    
    
    //@escaping se koristi kod vracanja completionHandlera, tj, kada ga pozivamo u closeru funkcije gde se nalazi
    func pripremaNotifikacije(zaVremeUSekundama: TimeInterval, completion: @escaping (_ uspesno: Bool) -> ()) {
        
        //dodavanje attachementa u notifikaciju
        let myImage = "rick_grimes"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return //ukoliko nije gard vrati false u completionu i iskoci odavde
        }
        
        let attachement = try! UNNotificationAttachment(identifier: "mojaNotifikacija", url: imageURL, options: nil)
        
        //pravljenje notifikacije
        let notifikacija = UNMutableNotificationContent()
        
        notifikacija.categoryIdentifier = "myNotificationCategory" //ovo je samo za ekstenzije notifikacije
        
        notifikacija.title = "Nova notifikaicja"
        notifikacija.subtitle = "Notifikacije su korisna stvar."
        notifikacija.body = "@escaping se koristi kod vracanja completionHandlera, tj, kada ga pozivamo u closeru funkcije gde se nalazi"
        notifikacija.attachments = [attachement]
        
        let okidacNotifikacije = UNTimeIntervalNotificationTrigger(timeInterval: zaVremeUSekundama, repeats: false) //necu da se okidac ponavlja iznova i iznova
        
        let request = UNNotificationRequest(identifier: "mojaNotifikacija", content: notifikacija, trigger: okidacNotifikacije)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error!.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }

}

