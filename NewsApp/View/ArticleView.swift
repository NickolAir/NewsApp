import UIKit

class ArticleViewCell: UITableViewCell {

    var viewModel: TableViewCell.News? {
        didSet {
            updateUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    func updateUI() {
        guard let viewModel else { return }
        
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.publishedAt
        authorLabel.text = viewModel.author
        contentLabel.text = viewModel.content
    }
    
    func setupUI() {
        contentView.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(dateLabel)
        mainView.addSubview(authorLabel)
        mainView.addSubview(contentLabel)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CellConstraints.leftPadding.value),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CellConstraints.rightPadding.value),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CellConstraints.bottomPadding.value),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellConstraints.topPadding.value),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: TitleLabelConstrains.top.value),
            titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: TitleLabelConstrains.leftPadding.value),
            titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: TitleLabelConstrains.rightPadding.value),
            
            dateLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: DateLabelConstraints.leftPadding.value),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DateLabelConstraints.top.value),
            
            authorLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: AuthorLabelConstraints.leftPadding.value),
            authorLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: AuthorLabelConstraints.top.value),
            
            contentLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: ContentLabelConstraints.leftPadding.value),
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: ContentLabelConstraints.top.value),
            contentLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: ContentLabelConstraints.rightPadding.value),
            contentLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: ContentLabelConstraints.bottomPadding.value)
        ])
    }
    
    enum TitleLabelConstrains {
        case top
        case leftPadding
        case rightPadding
        
        var value: CGFloat {
            switch self {
            case .top:
                return 10
            case .leftPadding:
                return 20
            case .rightPadding:
                return -20
            }
        }
    }

    enum DateLabelConstraints {
        case leftPadding
        case top
        
        var value: CGFloat {
            switch self {
            case .top:
                return 5
            case .leftPadding:
                return 20
            }
        }
    }

    enum AuthorLabelConstraints {
        case leftPadding
        case top
        
        var value: CGFloat {
            switch self {
            case .top:
                return 5
            case .leftPadding:
                return 20
            }
        }
    }

    enum ContentLabelConstraints {
        case leftPadding
        case top
        case rightPadding
        case bottomPadding
        
        var value: CGFloat {
            switch self {
            case .top:
                return 10
            case .leftPadding:
                return 20
            case .rightPadding:
                return -20
            case .bottomPadding:
                return -12
            }
        }
    }

    enum CellConstraints {
        case leftPadding
        case rightPadding
        case topPadding
        case bottomPadding
        
        var value: CGFloat {
            switch self {
            case .leftPadding:
                return 20
            case .rightPadding:
                return -20
            case .topPadding:
                return 12
            case .bottomPadding:
                return -12
            }
        }
    }
}
