//
//  MovieDetailAPI.swift
//  TMDB
//
//  Created by George Joseph Kristian on 29/05/22.
//

import Foundation
import SwiftUI

open
class MovieDetailAPI: ObservableObject {
    @Published var movieDetail: MovieDetailModel!
//    @Published var movieDetailState: StateAPI = .initial
    var movieID : Int = 0
    @Published var overView: String = ""
    @Published var releaseDate: String = ""
    @Published var voteAverage: String = ""
    @Published var movieTitle: String = ""
    @Published var backdropPath: String = ""
    
    
    func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US") else {
            fatalError("Missing URL")
        }

        movieTitle = "Loading..."
        releaseDate = "..."
        voteAverage = "..."
        overView = "Loading..."
        
        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                        self.movieDetail = decoded
                        self.movieTitle = decoded.title
                        self.releaseDate = decoded.releaseDate
                        self.voteAverage = String(decoded.voteAverage)
                        self.overView = decoded.overview
                        self.backdropPath = decoded.backdropPath
                    } catch let error {
                        debugPrint("Error decoding: ", error)
                        self.movieTitle = "Not Found"
                        self.releaseDate = "-"
                        self.voteAverage = "-"
                        self.overView = "-"
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
