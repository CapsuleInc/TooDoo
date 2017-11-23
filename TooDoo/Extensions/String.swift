//
//  String.swift
//  TooDoo
//
//  Created by Cali Castle  on 11/19/17.
//  Copyright © 2017 Cali Castle . All rights reserved.
//

import Foundation

extension String {
    
    /// Localized shortcut.
    
    var localized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    /// Localized with comment.
    
    func localized(with comment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    /// Localized with plural.
    
    func localizedPlural(_ variable: Int) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: [variable])
    }
    
}
