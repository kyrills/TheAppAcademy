import UIKit

class ShoppingDetailCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var diveLocation: UITextField!
    @IBOutlet weak var depthMetres: UITextField!
    @IBOutlet weak var oceanLabel: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
