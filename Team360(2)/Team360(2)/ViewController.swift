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

    // 각 팀원의 강점, 스타일, 주소 정보, 이미지
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
        firstTableView.backgroundColor = UIColor(hex: "#ffefd6") // 테이블뷰 배경색
        firstTableView.layer.cornerRadius = 20 // 모서리 둥글게 처리
        firstTableView.isScrollEnabled = false // 스크롤 제거
        firstTableView.separatorStyle = .none // 구분선 제거

        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        secondTableView.delegate = self
        secondTableView.dataSource = self
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath)

            // 이름과 이모지 설정
            let fullName = "\(teammate[indexPath.row])"
            cell.textLabel?.text = fullName

            // MBTI 레이블 추가
            if let mbtiLabel = cell.viewWithTag(100) as? UILabel {
                let mbti = MBTI[indexPath.row]
                mbtiLabel.text = mbti

                // MBTI에 따라 색상 설정
                switch mbti {
                case "ESTJ":
                    mbtiLabel.backgroundColor = UIColor(hex: "#FCE6E6")
                case "INFP":
                    mbtiLabel.backgroundColor = UIColor(hex: "#EBFCE6")
                case "ISTP":
                    mbtiLabel.backgroundColor = UIColor(hex: "#E6F4FC")
                case "INTJ":
                    mbtiLabel.backgroundColor = UIColor(hex: "#D6D8FD")
                default:
                    mbtiLabel.backgroundColor = .gray
                }

                mbtiLabel.layer.cornerRadius = 10 // 원하는 크기로 조정
                mbtiLabel.layer.masksToBounds = true
                
                mbtiLabel.frame.size = CGSize(width: 60, height: 20)
                mbtiLabel.textAlignment = .center
                
                
            }

            return cell
        }
        
        return UITableViewCell()
    }

    // 셀 선택 시 데이터 전달 및 segue 실행
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ShowTeammateDetail" {
            return false // 🚀 자동 실행 방지
        }
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == secondTableView {
            let selectedTeammate = teammate[indexPath.row]

            // 팀원의 정보 가져오기
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

                // 데이터 전달 후 segue 실행
                performSegue(withIdentifier: "ShowTeammateDetail", sender: dataToSend)
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // segue에서 데이터 받기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTeammateDetail" {
            if let teammateDetailVC = segue.destination as? TeammateDetailViewController {
                if let data = sender as? [String: Any] {
                    teammateDetailVC.teammateName = data["name"] as? String ?? "이름 없음"
                    teammateDetailVC.teammateStrength = data["strength"] as? String ?? "강점 없음"
                    teammateDetailVC.teammateStyle = data["style"] as? String ?? "스타일 없음"
                    teammateDetailVC.teammateAdress = data["adress"] as? String ?? "주소 없음"
                    teammateDetailVC.teammateImageName = data["imageName"] as? String ?? ""
                }
            }
        }
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
