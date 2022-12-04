//
//  UIView+Extension.swift
//  YelpReviewApp
//
//  Created by LilHoe on 12/3/22.
//

import UIKit

extension UIView {
    func closestVC() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let vc = responder as? UIViewController {
                return vc
            }
            responder = responder?.next
        }
        return nil
    }
}

