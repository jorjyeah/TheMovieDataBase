//
//  MoviesView.swift
//  TMDB
//
//  Created by George Joseph Kristian on 25/05/22.
//

import SwiftUI

enum ContentType: String {
    case movies = "Movies"
    case tvShows = "TV Shows"
}

struct HomeView: View {
    @State private var contentType : ContentType = .movies
    let contents = [ContentType.movies, ContentType.tvShows]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack(alignment:.center){
                Picker("Choose Content", selection: $contentType) {
                    ForEach(contents, id:\.self) { content in
                                Text(content.rawValue).tag(content)
                            }
                        }
                        .pickerStyle(.segmented)
                switch contentType {
                case .movies:
                    MoviesView()
                case .tvShows:
                    ProfileView()
                }
                Spacer()
            }.background(Color.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
