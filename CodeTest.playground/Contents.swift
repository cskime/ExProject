import UIKit
import Foundation

var threshold = 2
var count = 0
"555550055555"
"555557555525"


/* State 1 : Checking(5s)
 *  - State 1-1 : Upper
 *  - State 1-2 : Lower
 * State 2 : Easing(2s)
*/

func check(sgn: Int) -> Bool {
    lower(sgn: sgn)
    upper(sgn: sgn)
    return count > 3
}

func lower(sgn: Int) {
    if sgn < threshold {
        count = 0
    }
}

func upper(sgn: Int) {
    if sgn > threshold {
        count += 1
    }
}

while true {
    let _signal = Int(arc4random_uniform(10))
    print("Signal : \(_signal)")
    
    if check(sgn: _signal) {
        print("Error")
        break;
    } else {
        print("OK")
    }
    sleep(1)
}
