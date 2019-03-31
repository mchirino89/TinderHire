//
//  Extension.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 31/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
