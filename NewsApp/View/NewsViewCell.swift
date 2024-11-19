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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
    
    func updateUI() {
        guard let viewModel else { return }
        
        dateLabel.text = viewModel.publishedAt
        titleLabel.text = viewModel.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        dateLabel.text = nil
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
            mainView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: TitleLabelConstrains.top.value),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: TitleLabelConstrains.leftPadding.value),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: TitleLabelConstrains.rightPadding.value),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DateLabelConstraints.top.value),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DateLabelConstraints.leftPadding.value),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: DateLabelConstraints.rightPadding.value),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: DateLabelConstraints.bottom.value)
        ])
    }
    
    enum TitleLabelConstrains {
        case top
        case rightPadding
        case leftPadding
        
        var value: CGFloat {
            switch self {
            case .rightPadding:
                return -16
            case .top:
                return 10
            case .leftPadding:
                return 16
            }
        }
    }

    enum DateLabelConstraints {
        case top
        case bottom
        case leftPadding
        case rightPadding
        
        var value: CGFloat {
            switch self {
            case .bottom:
                return -10
            case .top:
                return 4
            case .leftPadding:
                return 16
            case .rightPadding:
                return -16
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
                return 5
            case .bottomPadding:
                return -5
            }
        }
    }
}
