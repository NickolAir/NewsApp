import Foundation
import Combine

class NewsViewModel {
    @Published var articles: [TableViewCell.News] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()
    private var newsService = NewsService()

    private var currentQuery: String = ""
    private var currentPage = 1
    private var selectedSortBy: String = "publishedAt"

    func searchNews(query: String) {
        guard query.count >= 3 else {
            articles = []
            error = "Введите не менее 3 символов для поиска."
            return
        }

        currentQuery = query
        currentPage = 1
        articles = []
        fetchNews()
    }

    func loadMore() {
        guard !isLoading, !currentQuery.isEmpty else { return }
        currentPage += 1
        fetchNews()
    }

    func changeSortOrder(to sortBy: String) {
        guard selectedSortBy != sortBy else { return }
        selectedSortBy = sortBy
        currentPage = 1
        articles = []
        fetchNews()
    }

    private func fetchNews() {
        isLoading = true
        newsService.fetchNews(query: currentQuery, sortBy: selectedSortBy, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.error = "Ошибка загрузки данных: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] fetchedArticles in
                self?.error = nil
                let news = fetchedArticles.map {
                    TableViewCell.News(
                        author: $0.author,
                        title: $0.title,
                        publishedAt: $0.publishedAt,
                        content: $0.content
                    )
                }
                if self?.currentPage == 1 {
                    self?.articles = news
                } else {
                    self?.articles.append(contentsOf: news)
                }
            })
            .store(in: &cancellables)
    }
}
