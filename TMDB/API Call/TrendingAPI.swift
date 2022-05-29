//
//  TrendingAPI.swift
//  TMDB
//
//  Created by George Joseph Kristian on 27/05/22.
//

import Foundation

open
class TrendingAPI: ObservableObject {
    @Published var trending: TrendingModel!
    @Published var trendingState: StateAPI = .initial
    @Published var trendingResults: [TrendingResult] = []
    @Published var trendingCount: Int = 0
    
    func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else {
            self.trendingState = .error
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
                    self.trendingState = .loading
                    do {
                        let decoded = try JSONDecoder().decode(TrendingModel.self, from: data)
                        self.trending = decoded
                        self.trendingResults = decoded.results
                        self.trendingCount = decoded.results.count
                        self.trendingState = .done
                    } catch let error {
                        print("Error decoding: ", error)
                        self.trendingState = .error
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
