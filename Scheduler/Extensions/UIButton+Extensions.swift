//
//  UIButton+Extensions.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 28.03.2021.
//

import UIKit

extension UIButton {

    // MARK: - Functions

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let rect = CGRect(
            origin: .zero,
            size: CGSize(width: 1.0, height: 1.0)
        )
        UIGraphicsBeginImageContextWithOptions(
            rect.size,
            false,
            .zero
        )
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(image, for: state)
    }
}
