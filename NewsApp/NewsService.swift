import Foundation
import Combine

class NewsService {
    private let baseURL = "https://newsapi.org/v2/everything"
    private let apiKey = "daf3130f54e54c4998270aac513ea83b"

    func fetchNews(query: String, sortBy: String, page: Int) -> AnyPublisher<[Response.Article], Error> {
        guard query.count >= 3 else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sortBy", value: sortBy),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = components.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .map { $0.articles } 
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
