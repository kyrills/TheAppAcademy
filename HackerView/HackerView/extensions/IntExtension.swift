import Foundation
extension Int {

    func timePassed() -> String{
    
        let timestampNow = NSDate().timeIntervalSince1970
        let timeDiff = timestampNow - TimeInterval(self)
        let minutes = Int(timeDiff/60)
        if minutes == 1{
            return "\(minutes) minute old"
        }
        else if minutes < 60{
            return "\(minutes) minutes old"
        } else{
            let hours = Int(minutes/60)
            return "Over \(hours) hours old."
        }
    }
}
