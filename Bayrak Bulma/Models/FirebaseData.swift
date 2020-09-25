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
    

    
}
