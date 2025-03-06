//
//  TeammateDetailViewController.swift
//  Team360(2)
//
//  Created by 김기태 on 3/5/25.
//

import UIKit

class TeammateDetailViewController: UIViewController {

    // 변수 선언
    var teammateName: String?
    var teammateStrength: String?
    var teammateStyle: String?
    var teammateAdress: String?
    var teammateImageName: String?

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 팀원 이름, 사진, 정보 설정
        if let name = teammateName {
            nameLabel.text = name
        }
        if let strength = teammateStrength {
            strengthLabel.text = strength
        }
        if let style = teammateStyle {
            styleLabel.text = style
        }
        if let adress = teammateAdress {
            adressLabel.text = adress
        }
        if let imageName = teammateImageName {
            profileImageView.image = UIImage(named: imageName)
        }
    }
}

