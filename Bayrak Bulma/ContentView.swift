//
//  ContentView.swift
//  Bayrak Bulma
//
//  Created by Taha Sarıcan on 14.05.2020.
//  Copyright © 2020 Taha Sarıcan. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif


struct ContentView: View {
    @State private var bayrakIsimleri = ["Almanya", "Amerika", "Arjantin", "Avustralya", "Azerbaycan", "Belçika"].shuffled()
    @State private var uLkeler = [ThreadDataType]()
    @State private var cEvap = Int.random(in: 0...5)
  @State private var sKorGoster = false
  @State private var bAslik = ""
  @State private var mEsaj = ""
  @State private var sKor = 0
  @State private var ulkeAdi = "UlkeAdi"
  @State private var deger = "Amerika"
   
    func getData()-> Void{
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
                        self.uLkeler.append(msgData)
                    }
                }
            
            self.ulkeAdi = self.uLkeler[self.cEvap].msg
            }
        }
   
    
var body: some View {
    ZStack {
    
      LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

      VStack(spacing: 40) {
        VStack {
            Text(ulkeAdi)
            .foregroundColor(.red)
            .font(.headline)
            .fontWeight(.black)
        }.padding(.top, UIScreen.main.bounds.width * 0.1)
        
        ForEach(0 ..< 3) { numara in
          Button(action: {
            self.cEvapMesaj(numara)
          }) {
            Bayrak(bAyrakIsim: self.bayrakIsimleri[numara])
          }
        }
       

        Spacer()

        Text("Puanınız : \(sKor)")
            .font(.title)
            .fontWeight(.regular)
          .foregroundColor(.white)
      }
        }
    .alert(isPresented: $sKorGoster) {
      Alert(title: Text(bAslik), message: Text(mEsaj), dismissButton: .default(Text("Devam Et")) {
        self.sOruSor()
        })
    }
    .onAppear(perform: getData)
  }

  func cEvapMesaj(_ number: Int) {
    if number == cEvap {
      bAslik = "Doğru 👍🏻"
      mEsaj = "Bir Puan Kazandınız"
      sKor += 1
    } else {
      bAslik = "Yanlış 👎🏻"
        mEsaj = "Yanlış Cevap Verdiniz ve Bir Puanı Kaybettiniz"
      if sKor > 0 {
        sKor -= 1
      }
    }

    sKorGoster = true
    
  }

  func sOruSor() {
    uLkeler.shuffle()
    cEvap = Int.random(in: 0...4)
    getData()
  }
}

struct Bayrak: View {
    
  var bAyrakIsim: String

  var body: some View {
    Image(self.bAyrakIsim)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule()
      .stroke(Color.white, lineWidth: 2))
      .shadow(color: .black, radius: 2)
    }
}
