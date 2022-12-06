
import Foundation
import EventKit

public struct ByDayValue {
    public var byweekday : EKWeekday
    public var nth: Int?


    public init(byweekday : EKWeekday, nth: Int? = nil) {
      self.byweekday = byweekday
      self.nth = nth
    }

    public func toSymbol() -> String {
        var symbol = ""

        if self.nth != nil {
            symbol += "\(nth!)"
        }

        switch self.byweekday {
        case .monday: symbol += "MO"
        case .tuesday: symbol += "TU"
        case .wednesday: symbol += "WE"
        case .thursday: symbol += "TH"
        case .friday: symbol += "FR"
        case .saturday: symbol += "SA"
        case .sunday: symbol += "SU"
        }

        return symbol
    }

    static func byDayValueFromSymbol(_ symbol: String) -> ByDayValue? {
        // MO, TU, ...
        if symbol.count == 2 {
            guard let weekday = EKWeekday.weekdayFromSymbol(symbol) else {
                return nil
            }

            return ByDayValue(byweekday: weekday)
        }

        // -1MO, +3FR, 1SO, 13TU ...
        let daySuffixes = ["MO", "TU", "WE", "TH", "FR", "SA", "SU"]
        let day = String(symbol.suffix(2))

        if !daySuffixes.contains(day) {
            return nil
        }

        guard let wday = EKWeekday.weekdayFromSymbol(day) else {
            return nil
        }

        let endIndex = symbol.index(symbol.endIndex, offsetBy: -2)
        let nth = String(symbol[symbol.startIndex..<endIndex])

        return ByDayValue(byweekday: wday, nth: nth.count > 0 ? Int(nth) : nil)
    }
}

extension ByDayValue: Comparable {
    public static func < (lhs: ByDayValue, rhs: ByDayValue) -> Bool {
        return lhs.byweekday.toNumberSymbol() < rhs.byweekday.toNumberSymbol()
    }

    public static func > (lhs: ByDayValue, rhs: ByDayValue) -> Bool {
        return lhs.byweekday.toNumberSymbol() > rhs.byweekday.toNumberSymbol()
    }

    public static func == (lhs: ByDayValue, rhs: ByDayValue) -> Bool {
        return lhs.byweekday.toNumberSymbol() == rhs.byweekday.toNumberSymbol()
    }
}
