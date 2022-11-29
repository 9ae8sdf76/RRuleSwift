
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
            var weekday = EKWeekday.weekdayFromSymbol(symbol)
            if weekday != nil {
                return ByDayValue(byweekday: weekday)
            }
            else {
                return nil
            }
        }

        // -1MO, +3FR, 1SO, 13TU ...
        let searchRegex : Regex = try Regex("^([+-]?\\d{1,3})(MO|TU|WE|TH|FR|SA|SU)$")

        if let result = try? searchRegex.wholeMatch(in: symbol) {
            return ByDayValue(byweekday: EKWeekday.weekdayFromSymbol(result[2].value!), nth:  Int(result[1].value!))
        } else {
            return nil
        }
        
    }
}
