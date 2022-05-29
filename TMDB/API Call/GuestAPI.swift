//
//  GuestAPI.swift
//  TMDB
//
//  Created by George Joseph Kristian on 26/05/22.
//

import Foundation


open
class GuestAPI: ObservableObject {
    @Published var guest: GuestModel!
    
    func authGuestSession(completion:@escaping (GuestModel) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=\(apiKey)") else { fatalError("Missing URL") }

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
                        let decoded = try JSONDecoder().decode(GuestModel.self, from: data)
                        self.guest = decoded
                        completion(self.guest)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
