//
//  Truncate.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 11/25/23.
//

import SwiftUI

extension String {
    func truncated ( maxLength: Int) -> String {
        if self.count <= maxLength {
            return self
        } else {
            let truncatedIndex = self.index(self.startIndex, offsetBy: maxLength)
            return String(self[..<truncatedIndex]) + "..."
        }
    }
}
