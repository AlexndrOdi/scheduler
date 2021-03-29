//
//  UIEdgeInsets+Extensions.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import UIKit

extension UIEdgeInsets {

    // MARK: - Properties

    var horizontal: CGFloat { left + right }
    var vertical: CGFloat { top + bottom }
}
