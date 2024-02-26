//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Ranjit Mahto on 16/09/23.
//

import Foundation

extension Decimal {
    var doubleValue : Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
