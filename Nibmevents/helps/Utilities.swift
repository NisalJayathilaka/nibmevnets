//
//  Utilities.swift
//  Nibmevents
//
//  Created by nisal jayathilaka on 2/18/20.
//  Copyright © 2020 nisal jayathilaka. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
        
        
    }
    
}
