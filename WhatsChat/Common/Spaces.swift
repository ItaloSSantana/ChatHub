import UIKit

enum Space: RawRepresentable, Equatable, Hashable, CaseIterable {
    
    public typealias RawValue = CGFloat
    case none
    case base00
    case base01
    case base02
    case base03
    case base04
    case base05 ///24
    case base06
    case base07
    case base08
    case base09
    case base10
    case base11
    case base12
    case base13
    case base14
    case base15 ///64
    case base16
    case base17
    case base18
    case base19
    case base20
    case base21
    case base22
    case base23
    case base24 /// 100
    case base25 ///104
    case base26 /// 108
    case base27 /// 112
    case base28
    case base29
    case base30
    public var rawValue: RawValue {
        switch self {
        case .base00:
            return 4
        case .base01:
            return 8
        case .base02:
            return 12
        case .base03:
            return 16
        case .base04:
            return 20
        case .base05:
            return 24
        case .base06:
            return 28
        case .base07:
            return 32
        case .base08:
            return 36
        case .base09:
            return 40
        case .base10:
            return 44
        case .base11:
            return 48
        case .base12:
            return 52
        case .base13:
            return 56
        case .base14:
            return 60
        case .base15:
            return 64
        case .base16:
            return 68
        case .base17:
            return 72
        case .base18:
            return 76
        case .base19:
            return 80
        case .base20:
            return 84
        case .base21:
            return 88
        case .base22:
            return 92
        case .base23:
            return 96
        case .base24:
            return 100
        case .base25:
            return 104
        case .base26:
            return 108
        case .base27:
            return 112
        case .base28:
            return 116
        case .base29:
            return 120
        case .base30:
            return 124
        default:
            return 0
        }
    }
    
    
    public init(rawValue: CGFloat) {
        self = Space
            .allCases
            .first {$0.rawValue == rawValue} ?? .none
    }
}
