//
//  BaseNibView.swift
//  ktb-next-exam
//
//  Created by p.wongkalasin on 9/10/2564 BE.
//

import UIKit

public protocol UseNibView {
    var nibName: String { get }
}

extension UseNibView where Self: UIView {
    func registerNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }
}

open class BaseNibView: UIView, UseNibView {
    public var nibName: String { type(of: self).description().components(separatedBy: ".").last ?? "" }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        registerNib()
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerNib()
        setupUI()
    }
    
    func setupUI() {
        
    }
}
