//
//  UIColor + Extension.swift
//  Team360(2)
//
//  Created by 박혜민 on 3/6/25.
//

import UIKit

class UIColor___Extension: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
