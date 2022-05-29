//
//  DiscoverAPI.swift
//  TMDB
//
//  Created by George Joseph Kristian on 28/05/22.
//

import Foundation

open
class DiscoverAPI: ObservableObject {
    @Published var discover: DiscoverModel!
    @Published var discoverState: StateAPI = .initial
    @Published var discoverResults: [DiscoverResult] = []
    @Published var discoverCount: Int = 0
    
    func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
            self.discoverState = .error
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
                    self.discoverState = .loading
                    do {
                        let decoded = try JSONDecoder().decode(DiscoverModel.self, from: data)
                        self.discover = decoded
                        self.discoverResults = decoded.results
                        self.discoverCount = decoded.results.count
                        self.discoverState = .done
                    } catch let error {
                        print("Error decoding: ", error)
                        self.discoverState = .error
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
