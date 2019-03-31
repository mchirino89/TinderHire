//
//  ReusableView.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 31/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

@IBDesignable
class ReusableView: UIView {

    private weak var proportionalHeightConstraint: NSLayoutConstraint?

    @IBOutlet var contentView: UIView!

    @IBInspectable var heightProportion: CGFloat = 0 {
        didSet {
            self.updateHeight()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }

    func xibSetup() {
        self.contentView = self.loadFromNib(self.xibName())
        self.contentView.frame = bounds
        self.contentView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentView)
        var constraints: [NSLayoutConstraint] = []
        let views = ["view": self.contentView!]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                      options: .alignAllTop, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                      options: .alignAllTop, metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
        self.updateHeight()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.updateHeight()
    }

    func xibName() -> String { return "" }

    private func updateHeight() {
        if self.heightProportion <= 0 {
            return
        }
        self.proportionalHeightConstraint?.isActive = false
        if let superview = self.superview {
            self.proportionalHeightConstraint = self.heightAnchor.constraint(equalTo: superview.heightAnchor,
                                                                             multiplier: self.heightProportion)
            self.proportionalHeightConstraint?.isActive = true
        }
    }

}
