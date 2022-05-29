//
//  LatestMovieAPI.swift
//  TMDB
//
//  Created by George Joseph Kristian on 30/05/22.
//

import Foundation

open
class LatestMovieAPI: ObservableObject {
    @Published var movieTitle: String = ""
    @Published var backdropPath: String = ""
    
    func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/latest?api_key=\(apiKey)&language=en-US") else {
            fatalError("Missing URL")
        }

        
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
                        let decoded = try JSONDecoder().decode(LatestMovieModel.self, from: data)
                        self.movieTitle = decoded.title
                        self.backdropPath = decoded.backdropPath ?? ""
                    } catch let error {
                        debugPrint("Error decoding: ", error)
                        self.movieTitle = "Not Found"
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
