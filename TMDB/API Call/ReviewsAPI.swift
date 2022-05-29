//
//  ReviewsAPI.swift
//  TMDB
//
//  Created by George Joseph Kristian on 29/05/22.
//
import Foundation

open
class ReviewsAPI: ObservableObject {
    @Published var reviews: ReviewsModel!
    @Published var reviewResults: [ReviewResult] = []
    @Published var reviewsCount: Int = 0
    @Published var reviewsTotalResults: Int = 0

    
    var movieID : Int = 0
    
    func getData(page: Int = 0) {
        var urlString : String = "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=\(apiKey)&language=en-US"
        
        if page != 0 {
            urlString.append("&page=\(page)")
        }
        
        debugPrint(urlString)
        
        guard let url = URL(string: urlString) else {
            fatalError("Missing URL")
        }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            debugPrint(response.statusCode)
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(ReviewsModel.self, from: data)
                        self.reviews = decoded
                        self.reviewResults = decoded.results
                        self.reviewsCount = decoded.results.count
                        self.reviewsTotalResults = decoded.totalResults
                        debugPrint(self.reviewResults)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}

