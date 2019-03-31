//
//  Extension.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 31/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

protocol UIViewLoading { }

extension UIView: UIViewLoading { }

extension UIViewLoading where Self: UIView {
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let bundle = Bundle(for: self)
        let probableName = "\(self)".split { $0 == "." }.map(String.init).last!
        let name = nibName ?? probableName
        let nib = UINib(nibName: name, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("Couldn't read from Nib")
        }
        return view
    }

    func loadFromNib(_ nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Couldn't read from Nib")
        }
        return view
    }
}
