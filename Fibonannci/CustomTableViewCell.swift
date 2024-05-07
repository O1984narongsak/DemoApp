import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
