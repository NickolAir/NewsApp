import UIKit

class ArticleViewController: UIViewController, UIScrollViewDelegate {
    
    private let article: TableViewCell.News
    
    init(article: TableViewCell.News) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = article.title
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Автор: \(article.author ?? "Неизвестно")"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Дата: \(article.publishedAt ?? "Неизвестно")"
        return label
    }()
    
    private lazy var articleTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .black
        textView.text = article.content
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(articleTextView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        articleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.topPadding),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutConstants.sidePadding),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutConstants.sidePadding),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutConstants.elementSpacing),
            authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutConstants.sidePadding),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutConstants.sidePadding),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: LayoutConstants.elementSpacing),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutConstants.sidePadding),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutConstants.sidePadding),
            
            articleTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: LayoutConstants.topPadding),
            articleTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutConstants.sidePadding),
            articleTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutConstants.sidePadding),
            articleTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.bottomPadding)
        ])

    }
    
    private enum LayoutConstants {
        static let topPadding: CGFloat = 16
        static let sidePadding: CGFloat = 16
        static let elementSpacing: CGFloat = 8
        static let bottomPadding: CGFloat = 16
    }
}
