
struct Response: Codable {
    struct Article: Codable {
        let author: String?
        let date: String?
        let title: String?
        let text: String?
    }
    let status: String
    let articles: [Article]
}
