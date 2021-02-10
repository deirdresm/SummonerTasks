//
//  SwiftUI+Extension.swift
//  SummonerTasks
//
//  Created by Deirdre Saoirse Moen on 1/19/21.
//

import Foundation
import SwiftUI

extension View {
    func printing<A>(_ value: A) -> Self {
        print(value)
        return(self)
    }
}
