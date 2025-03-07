import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!

    let teamCharacteristic = [
        ("우리팀의 특징", "개인의 성장과 팀의 발전을 함께 추구합니다."),
        ("궁극적인 목표", "하루 1%의 변화가 모이면, 1년 후 37배의 성장이 됩니다."),
        ("우리팀의 약속", "개발 과정에서 정직하고 투명한 커뮤니케이션을 유지합니다.")]
    let teammate: [String] = ["🙋🏻‍♀️박혜민", "🙆🏻‍♂️김기태", "🙋🏻‍♂️김형윤", "💁🏻‍♂️변준영"]
    let MBTI: [String] = ["ESTJ", "INFP", "ISTP", "INTJ"]

    let strength: [String: String] = [
        "🙋🏻‍♀️박혜민": "솔직한 커뮤니케이션",
        "🙆🏻‍♂️김기태": "최신 기술 트렌드에 대한 관심과 빠른 학습 능력",
        "🙋🏻‍♂️김형윤": "논리적으로 사고하고 분석하는걸 좋아함",
        "💁🏻‍♂️변준영": "이전 경력을 통해 폭 넓은 시야와 다양한 관점을 갖춤"]
    
    let style: [String: String] = [
        "🙋🏻‍♀️박혜민": "빠른 문제 해결을 위해 자주 소통하는 편",
        "🙆🏻‍♂️김기태": "문제 발생 시 원인을 분석하고 해결책을 공유",
        "🙋🏻‍♂️김형윤": "상대방의 스타일에 맞춰가는 편",
        "💁🏻‍♂️변준영": "적극적인 질문을 통해 문제를 발견하고 해결"]
    
    let adress: [String: String] = [
        "🙋🏻‍♀️박혜민": "https://velog.io/@hmpark15/posts",
        "🙆🏻‍♂️김기태": "https://ioskkt.tistory.com/",
        "🙋🏻‍♂️김형윤": "https://y-oon.tistory.com/",
        "💁🏻‍♂️변준영": "https://www.notion.so/CamCoder-18fa28cef94e8022aa29f8bed90e96ef?pvs=4"]
    
    let teammateImages: [String: String] = [
        "🙋🏻‍♀️박혜민": "박혜민.jpg",
        "🙆🏻‍♂️김기태": "김기태.jpg",
        "🙋🏻‍♂️김형윤": "김형윤.jpg",
        "💁🏻‍♂️변준영": "변준영.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        secondTableView.delegate = self
        secondTableView.dataSource = self

        secondTableView.register(SecondTableViewCell.self, forCellReuseIdentifier: "SecondCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstTableView {
            return teamCharacteristic.count
        } else if tableView == secondTableView {
            return teammate.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath)
            cell.textLabel?.text = teamCharacteristic[indexPath.row].0
            cell.detailTextLabel?.text = teamCharacteristic[indexPath.row].1
            return cell
        } else if tableView == secondTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as? SecondTableViewCell else {
                fatalError("SecondCell을 SecondTableViewCell로 캐스팅할 수 없습니다.")
            }

            let fullName = "\(teammate[indexPath.row])"
            cell.nameLabel.text = fullName
            let mbti = MBTI[indexPath.row]
            cell.mbtiLabel.text = mbti
            cell.mbtiLabel.backgroundColor = UIColor(hex: {
                switch mbti {
                case "ESTJ": return "#FCE6E6"
                case "INFP": return "#EBFCE6"
                case "ISTP": return "#E6F4FC"
                case "INTJ": return "#D6D8FD"
                default: return "#CCCCCC"
                }
            }())

            return cell
        }
        return UITableViewCell()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowTeammateDetail" {
            return false
        }
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == secondTableView {
            let selectedTeammate = teammate[indexPath.row]

            if let strengthValue = strength[selectedTeammate],
               let styleValue = style[selectedTeammate],
               let adressValue = adress[selectedTeammate],
               let imageName = teammateImages[selectedTeammate] {

                let dataToSend: [String: Any] = [
                    "name": selectedTeammate,
                    "strength": strengthValue,
                    "style": styleValue,
                    "adress": adressValue,
                    "imageName": imageName
                ]

                performSegue(withIdentifier: "ShowTeammateDetail", sender: dataToSend)
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTeammateDetail",
           let teammateDetailVC = segue.destination as? TeammateDetailViewController,
           let data = sender as? [String: Any] {
            teammateDetailVC.teammateName = data["name"] as? String ?? "이름 없음"
            teammateDetailVC.teammateStrength = data["strength"] as? String ?? "강점 없음"
            teammateDetailVC.teammateStyle = data["style"] as? String ?? "스타일 없음"
            teammateDetailVC.teammateAdress = data["adress"] as? String ?? "주소 없음"
            teammateDetailVC.teammateImageName = data["imageName"] as? String ?? ""
        }
    }
}

class SecondTableViewCell: UITableViewCell {
    let nameLabel = UILabel()
    let mbtiLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        mbtiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mbtiLabel.textAlignment = .center
        mbtiLabel.layer.cornerRadius = 10
        mbtiLabel.layer.masksToBounds = true
        mbtiLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        mbtiLabel.backgroundColor = .lightGray
        mbtiLabel.textColor = .black
        mbtiLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        contentView.addSubview(nameLabel)
        contentView.addSubview(mbtiLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            mbtiLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 12),
            mbtiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mbtiLabel.heightAnchor.constraint(equalToConstant: 30),
            mbtiLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    extension UIColor {
        convenience init(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            if hexSanitized.hasPrefix("#") {
                hexSanitized = String(hexSanitized.dropFirst())
            }
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
                self.init(white: 0.0, alpha: 1.0)
            }
        }
    }
