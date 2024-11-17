struct Response: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
    
    struct Article: Codable {
        let author: String?
        let title: String?
        let description: String?
        let content: String?
        let publishedAt: String?
        let url: String?
    }
}
