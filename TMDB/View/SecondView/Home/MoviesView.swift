//
//  MoviesView.swift
//  TMDB
//
//  Created by George Joseph Kristian on 25/05/22.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject private var trendingAPI = TrendingAPI()
    @ObservedObject private var discoverAPI = DiscoverAPI()
    @ObservedObject private var latestMovieAPI = LatestMovieAPI()

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack(alignment: .bottomLeading){
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/original\(trendingAPI.trendingResults.first?.backdropPath ?? "")"),
                    scale: 0.5)
                    {image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth, height: 270)
                            .clipped()
                    }
                    placeholder: {
                        ZStack(alignment: .center){
                            Rectangle()
                                .fill(Color.brown)
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                }
                Rectangle()
                    .fill(LinearGradient(colors: [Color.black, Color.clear], startPoint: .bottomLeading, endPoint: .center))
                Text(trendingAPI.trendingResults.first?.title ?? "")
                    .padding([.leading, .bottom], 16)
                    .foregroundColor(Color.white)
            }
            .frame(width: UIScreen.screenWidth, height: 270)
            .onAppear{
                latestMovieAPI.getData()
            }
            TrendingScrollView(trendingAPI: trendingAPI)
                .padding([.leading, .trailing], 16)
                .onAppear{
                    trendingAPI.getData()
                }
            DiscoverScrollView(discoverAPI: discoverAPI)
                .padding([.leading, .trailing], 16)
                .onAppear{
                    discoverAPI.getData()
                }
        }
    }
}

struct TrendingScrollView: View{
    @ObservedObject var trendingAPI: TrendingAPI
    
    var body: some View{
        Text("Trending")
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16){
                switch trendingAPI.trendingState {
                case .done:
                    ForEach(0..<trendingAPI.trendingCount) { index in
                        NavigationLink(destination: ThirdView(movieID: trendingAPI.trendingResults[index].id)) {
                            AsyncImage(
                                url: URL(string: "https://image.tmdb.org/t/p/original\(trendingAPI.trendingResults[index].posterPath)"),
                                scale: 0.5)
                                { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                }
                                placeholder: {
                                  
                                    ZStack(alignment: .center){
                                        Rectangle()
                                            .fill(Color.brown)
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    }
                            }
                                .frame(width: 180, height: 270)
                        }
                    }
               default:
                    ForEach(0..<10){ index in
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: 180, height: 270)
                    }
                }
            }
        }
    }
}

struct DiscoverScrollView: View{
    @ObservedObject var discoverAPI: DiscoverAPI
    
    var body: some View{
        Text("Discover")
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16){
                switch discoverAPI.discoverState {
                    
                case .done:
                    ForEach(0..<discoverAPI.discoverCount) { index in
                        NavigationLink(destination: ThirdView(movieID: discoverAPI.discoverResults[index].id)) {
                            AsyncImage(
                                url: URL(string: "https://image.tmdb.org/t/p/original\(discoverAPI.discoverResults[index].posterPath)"),
                                scale: 0.5)
                                { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                }
                                placeholder: {
                                    ZStack(alignment: .center){
                                        Rectangle()
                                            .fill(Color.brown)
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    }
                            }
                                .frame(width: 180, height: 270)
                        }
                    }
                default:
                     ForEach(0..<10){ index in
                         Rectangle()
                             .fill(Color.brown)
                             .frame(width: 180, height: 270)
                     }
                 }
                
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
