import UIKit
import Combine

class NewsViewController: UIViewController {
    
    private let viewModel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var segmentControl: UISegmentedControl = {
        .init(items: ["Date", "Popularity"])
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: String(describing: NewsViewCell.self))
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск новостей"
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }

    private func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Новости"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(segmentControl)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(sortOrderChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            segmentControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func setupBindings() {
        viewModel.$articles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    @objc private func sortOrderChanged() {
        let sortBy = segmentControl.selectedSegmentIndex == 0 ? "publishedAt" : "popularity"
        viewModel.changeSortOrder(to: sortBy)
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchNews(query: searchText)
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsViewCell.self), for: indexPath) as? NewsViewCell else {
            return UITableViewCell()
        }
        let article = viewModel.articles[indexPath.row]
        cell.viewModel = TableViewCell.News(author: article.author, title: article.title, publishedAt: article.publishedAt, content: article.content)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Article = viewModel.articles[indexPath.row]
        let articleVC = ArticleViewController(article: Article)
        navigationController?.pushViewController(articleVC, animated: true)
    }
}
