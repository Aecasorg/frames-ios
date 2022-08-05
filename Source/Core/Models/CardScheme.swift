//
//  CardScheme.swift
//  
//
//  Created by Alex Ioja-Yang on 05/08/2022.
//

public enum CardScheme {
    case unknown
    case mada
    case visa
    case mastercard
    case maestro
    case americanExpress
    case discover
    case dinersClub
    case jcb

    internal func mapToCheckoutCardScheme() -> Card.Scheme {
        switch self {
        case .unknown:
            return .unknown
        case .mada:
            return .mada
        case .visa:
            return .visa
        case .mastercard:
            return .mastercard
        case .maestro:
            return .maestro()
        case .americanExpress:
            return .americanExpress
        case .discover:
            return .discover
        case .dinersClub:
            return .dinersClub
        case .jcb:
            return .jcb
        }
    }
}
