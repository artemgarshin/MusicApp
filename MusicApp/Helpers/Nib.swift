//
//  Nib.swift
//  MusicApp
//
//  Created by Артем Гаршин on 30.08.2023.
//

import Foundation
import UIKit

extension UIView{
    
    
    class func loadFromNib<T: UIView>() -> T{
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil,options: nil)![0] as! T
        
    }
}
