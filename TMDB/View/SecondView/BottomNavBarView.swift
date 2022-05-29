//
//  BottomNavBarView.swift
//  TMDB
//
//  Created by George Joseph Kristian on 25/05/22.
//

import SwiftUI

enum Tabs: String{
    case TMDB
    case Profile
}

struct BottomNavBarView: View {
    @State private var selectedTab: Tabs = .TMDB
    @State private var searchText = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView().tag(Tabs.TMDB)
                .tabItem {
                Image(systemName: "house.fill")
                }.tag(Tabs.TMDB)
            ProfileView().tag(Tabs.Profile)
                .tabItem {
                Image(systemName: "person.fill")
                }.tag(Tabs.Profile)
        }
        .navigationTitle(selectedTab.rawValue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selectedTab == .Profile)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button(action: {
                    print("button pressed")
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}

struct BottomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavBarView()
    }
}
