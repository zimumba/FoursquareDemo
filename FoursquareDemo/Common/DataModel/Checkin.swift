import Foundation

@objc(Checkin)
open class Checkin: _Checkin {

    var creationDate: Date {
        return Date(timeIntervalSince1970: self.createdAt.doubleValue)
    }
}
