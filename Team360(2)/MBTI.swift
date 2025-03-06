import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let teamMemberEmojis: [String] = ["🙋🏻‍♀️", "🙆🏻‍♂️", "🙋🏻‍♂️", "💁🏻‍♂️"]
    let teamMemberNames: [String] = ["박혜민", "김기태", "김형윤", "변준영"]
    let teamMemberTags: [String] = ["ESTJ", "INFP", "ISTP", "INTJ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.separatorStyle = .none
        myTableView.contentInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 0)
    
    myTableView.reloadData()
    let height = myTableView.contentSize.height + myTableView.contentInset.top + myTableView.contentInset.bottom
    myTableView.frame.size.height = height
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMemberNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myFirstCell", for: indexPath)
        let fullName = "\(teamMemberEmojis[indexPath.row])  \(teamMemberNames[indexPath.row])"
            cell.textLabel?.text = fullName
    
        if let tagLabel = cell.viewWithTag(100) as? UILabel {  // 태그는 100으로 설정
            tagLabel.text = teamMemberTags[indexPath.row]
            
            switch teamMemberTags[indexPath.row] {
            case "ESTJ":
                tagLabel.backgroundColor = UIColor(hex: "#FCE6E6")
            case "INFP":
                tagLabel.backgroundColor = UIColor(hex: "#EBFCE6")
            case "ISTP":
                tagLabel.backgroundColor = UIColor(hex: "#E6F4FC")
            case "INTJ":
                tagLabel.backgroundColor = UIColor(hex: "#D6D8FD")
            default:
                tagLabel.backgroundColor = .gray
            }
            tagLabel.layer.cornerRadius = 10 // 원하는 크기로 조정
            tagLabel.layer.masksToBounds = true
            
                
            // 이미지뷰 생성
            let arrowImageView = UIImageView(image: UIImage(named: "arrowIcon"))
            arrowImageView.contentMode = .scaleAspectFit
            cell.contentView.addSubview(arrowImageView)

            // 오른쪽 끝으로 배치
            arrowImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                arrowImageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -25),
                arrowImageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])

        }
        return cell
    }
}

// UIColor 확장을 작성해서 hex 값을 처리할 수 있도록 합니다.
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // '#' 제거
        if hexSanitized.hasPrefix("#") {
            hexSanitized = String(hexSanitized.dropFirst())
        }
        
        // HEX 코드의 길이가 6인지 확인
        if hexSanitized.count == 6 {
            let scanner = Scanner(string: hexSanitized)
            var rgb: UInt64 = 0
            scanner.scanHexInt64(&rgb)
            
            self.init(
                red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgb & 0x0000FF) / 255.0,
                alpha: 1.0
            )
        } else {
            self.init(white: 0.0, alpha: 1.0) // 기본값은 검정색
        }
    }
}
