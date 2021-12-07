//
//  UIImageView.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/24/21.
//
import UIKit

extension UIImageView {
        func loadImage(urlString : String) {
            guard let url = URL(string: urlString)else {
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
    }
}

