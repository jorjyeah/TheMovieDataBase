//
//  ContentView.swift
//  TMDB
//
//  Created by George Joseph Kristian on 25/05/22.
//

import SwiftUI

struct FirstView: View {
    @State var guest: GuestModel!
    @State var success: Bool = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 64.0) {
                Text("TMDB").font(Font.title).bold()
                Button(action: {
                    GuestAPI().authGuestSession { guest in
                        self.guest = guest
                        if let unwrapped = self.guest {
                            print("\(unwrapped.guestSessionID)")
                            success = true
                        } else {
                            print("Failed.")
                            success = false
                        }
                    }
                }){
                    Text("Guest")
                }
                NavigationLink(destination: SecondView(), isActive: $success){
                }
            }
        }
        .navigationBarHidden(true)
        .environmentObject(GuestAPI())
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
