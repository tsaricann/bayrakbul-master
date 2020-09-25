//
//  FirebaseData.swift
//  Bayrak Bulma
//
//  Created by Ceren on 23.09.2020.
//  Copyright © 2020 Halil İbrahim Uslu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

let dbCollection = Firestore.firestore().collection("ulkeler")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject {
    
    @Published var data = [ThreadDataType]()
    
    init() {
        readData()
    }
    
    // Reference link : https://firebase.google.com/docs/firestore/query-data/listen
    func readData() {
        dbCollection.addSnapshotListener { (documentSnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("read data success")
            }
            
            documentSnapshot!.documentChanges.forEach { diff in
                // Real time create from server
                if (diff.type == .added) {
                    let msgData = ThreadDataType(id: diff.document.documentID, msg: diff.document.get("adi") as! String)
                    self.data.append(msgData)
                }
                
                print(self.data)
             
            }
        }
    }
    
}
