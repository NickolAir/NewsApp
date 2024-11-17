import UIKit
import Combine

class ArticleViewController: UIViewController {
    private let article: TableViewCell.News?
    
    init (article: TableViewCell.News) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
