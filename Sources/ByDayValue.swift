
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

extension ByDayValue {
    static fileprivate var weekdayInts = ["MO": 1, "TU": 2, "WE": 3, "TH": 4, "FR": 5, "SA": 6, "SU": 7]
    static func < (lhs: ByDayValue, rhs: ByDayValue) -> Bool {
        guard let leftSymbol = weekdayInts[String(lhs.toSymbol().suffix(2))] else {
            return false
        }

        guard let rightSymbol = weekdayInts[String(rhs.toSymbol().suffix(2))] else {
            return false
        }

        return leftSymbol < rightSymbol
    }

    static func > (lhs: ByDayValue, rhs: ByDayValue) -> Bool {
        guard let leftSymbol = weekdayInts[String(lhs.toSymbol().suffix(2))] else {
            return false
        }

        guard let rightSymbol = weekdayInts[String(rhs.toSymbol().suffix(2))] else {
            return false
        }

        return leftSymbol > rightSymbol
    }

    static func == (lhs: ByDayValue, rhs: ByDayValue) -> Bool {
        guard let leftSymbol = weekdayInts[String(lhs.toSymbol().suffix(2))] else {
            return false
        }

        guard let rightSymbol = weekdayInts[String(rhs.toSymbol().suffix(2))] else {
            return false
        }

        return leftSymbol == rightSymbol
    }
}
