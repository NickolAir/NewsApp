import UIKit

class NewsViewCell: UITableViewCell {
    
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
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    func updateUI() {
        guard let viewModel else { return }
        
        dateLabel.text = viewModel.publishedAt
        titleLabel.text = viewModel.title
    }
    
    func setupUI() {
        contentView.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(dateLabel)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CellConstraints.leftPadding.value),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CellConstraints.rightPadding.value),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CellConstraints.bottomPadding.value),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CellConstraints.topPadding.value),
            
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: TitleLabelConstrains.top.value),
            titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: TitleLabelConstrains.leftPadding.value),
            
            dateLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: DateLabelConstraints.leftPadding.value),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DateLabelConstraints.top.value),
        ])
    }
    
    enum TitleLabelConstrains {
        case top
        case bottom
        case leftPadding
        
        var value: CGFloat {
            switch self {
            case .bottom:
                return 20
            case .top:
                return 10
            case .leftPadding:
                return 20
            }
        }
    }

    enum DateLabelConstraints {
        case top
        case bottom
        case leftPadding
        
        var value: CGFloat {
            switch self {
            case .bottom:
                return 10
            case .top:
                return 10
            case .leftPadding:
                return 20
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
