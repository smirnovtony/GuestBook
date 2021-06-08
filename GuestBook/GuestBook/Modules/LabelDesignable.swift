//
//  labelDesignable.swift
//  GuestBook
//
//  Created by iOS NavekSoft on 8.06.21.
//

import UIKit

@IBDesignable class LabelDesignable : UILabel {
    @IBInspectable override var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    @IBInspectable var shadowRadius: CGFloat {
        set {  layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    @IBInspectable var _clipsToBounds: Bool {
        set { clipsToBounds = newValue }
        get { return clipsToBounds }
    }
}
