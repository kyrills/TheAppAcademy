import UIKit

class HackerViewCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UITextView!
    @IBOutlet weak var articleAuthor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleTitle.text = nil
        articleAuthor.text = nil
    }
    
}
