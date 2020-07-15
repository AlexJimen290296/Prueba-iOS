import Foundation
import UIKit

class CameraCustomCell: UITableViewCell {
    @IBOutlet weak var imageViewCamera: UIImageView!
    
}

class ImageCustomCell: UITableViewCell {
    @IBOutlet weak var imageViewImage: UIImageView!
    
}

class NameCustomCell: UITableViewCell {
    @IBOutlet weak var textFieldName: UITextField!
}

class TelephoneCustomCell: UITableViewCell {
    @IBOutlet weak var textFieldTelephone: UITextField!
    
}

class BirthdayCustomCell: UITableViewCell {
    @IBOutlet weak var textFieldBirthday: UITextField!
    
}

class GenderCustomCell: UITableViewCell {
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelGender: UILabel!
    
}

class ColorCustomCell: UITableViewCell {
    @IBOutlet weak var imageViewCheck: UIImageView!
    
}
