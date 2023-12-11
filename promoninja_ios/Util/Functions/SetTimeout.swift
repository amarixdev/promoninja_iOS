//
//  SetTimeout.swift
//  promoninja_ios
//
//  Created by Amari DeVaughn on 12/10/23.
//

import SwiftUI

func setTimeout (_ seconds: CGFloat, _ closure: @escaping ()-> Void) -> Void {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}

