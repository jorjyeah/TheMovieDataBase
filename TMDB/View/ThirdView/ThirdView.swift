//
//  ThirdView.swift
//  TMDB
//
//  Created by George Joseph Kristian on 25/05/22.
//

import SwiftUI

struct ThirdView: View {
    @State var movieID : Int!
    
    @ObservedObject var movieDetailAPI = MovieDetailAPI()
    @ObservedObject var reviewsAPI = ReviewsAPI()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 16){
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/original\(movieDetailAPI.backdropPath)"),
                        scale: 0.5)
                        {image in
                            image.resizable()
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
                        .frame(width: UIScreen.screenWidth, height: 270)
                    HStack{
                        Text(movieDetailAPI.voteAverage)
                        Spacer()
                        Image(systemName: "hand.thumbsup.fill")
                        Image(systemName: "hand.thumbsdown.fill")
                    }.padding([.leading, .trailing])
                    Divider()
                }
                VStack(alignment: .leading, spacing: 8){
                    Text("Overview").font(.title2)
                    Text(movieDetailAPI.overView)
                }.padding([.leading, .trailing])
                VStack(alignment: .leading, spacing: 8){
                    Text("Release Date").font(.title2)
                    Text(movieDetailAPI.releaseDate)
                }.padding([.leading, .trailing])
                VStack(alignment: .leading, spacing: 8){
                    Text("Review").font(.title2)
                    ForEach(0..<reviewsAPI.reviewsCount, id: \.self) {index in
                        ReviewCell(reviewer: reviewsAPI.reviewResults[index].authorDetails.username, reviewContent: reviewsAPI.reviewResults[index].content, avatarPath: reviewsAPI.reviewResults[index].authorDetails.avatarPath ?? "")
                    }
                    if reviewsAPI.reviewsCount > reviewsAPI.reviewsTotalResults {
                        HStack {
                            Spacer()
                            Button(action: {
                                reviewsAPI.getData()
                            }){
                                Text("See all reviews")
                            }
                            .tint(Color.gray)
                            .frame( alignment: .trailing)
                        }
                    }
                }.padding([.leading, .trailing])
                
                Spacer()
            }
        }.onAppear(perform: {
            movieDetailAPI.movieID = movieID
            movieDetailAPI.getData()
            reviewsAPI.movieID = movieID
            reviewsAPI.getData(page: 1)
        })
        .navigationTitle(movieDetailAPI.movieTitle)
        .navigationBarTitleDisplayMode(.inline)
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


struct ReviewCell: View {
    @State var lineLimit: Int? = 3
    @State var isExpanding: Bool = false
    @State var reviewer: String = "-"
    @State var reviewContent: String = "-"
    @State var avatarPath: String = "-"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            HStack{
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/original\(avatarPath)"),
                    scale: 0.5)
                    { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipped()
                    }
                    placeholder: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .clipped()
                    }
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                
                Text(reviewer)
                Spacer()
            }
            Text(reviewContent).lineLimit(lineLimit)
            HStack{
                Spacer()
                Button(action: {
                    lineLimit = isExpanding ? 3 : nil
                    isExpanding = !isExpanding
                }){
                    Text("more")
                }
                .tint(Color.gray)
                .frame( alignment: .trailing)
            }
        }
        .padding(.all)
        .border(.gray)
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
