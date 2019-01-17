import UIKit
import Foundation

var threshold = 3
var count = 0
var signals = "555250055545555557555525557555522345532235673665432" as NSString

protocol State {
    // functions
    func inputSignal(sgn: Int)
}

class CheckFirst: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(sgn: Int) {
        if sgn > threshold {
            print("Check1 : OVER - \(sgn)")
            count += 1
        } else {
            print("Check1: OK - \(sgn)")
            count = 0
        }
        
        if count == 5 {
            checkSignals.setState(state: checkSignals.getRestState())
            count = 0
        }
    }
}

class Rest: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(sgn: Int) {
        print("Rest : \(sgn)")
        count += 1
        
        if count == 2 {
            checkSignals.setState(state: checkSignals.getCheckSecondState())
            count = 0
        }
    }
}

class CheckSecond: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(sgn: Int) {
        if sgn > threshold {
            print("Check2 : OVER - \(sgn)")
            count += 1
        } else {
            print("Check2: OK - \(sgn)")
            checkSignals.setState(state: checkSignals.getCheckFirstState())
            count = 0
        }
        
        if count == 5 {
            checkSignals.setState(state: checkSignals.getResetState())
            count = 0
        }
    }
}

class Reset: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(sgn: Int) {
        print("Reset")
        count += 1
        
        if count == 10 {
            checkSignals.setState(state: checkSignals.getCheckFirstState())
        }
    }
}

class CheckSignals {
    var checkFirstState: State!
    var restState: State!
    var checkSecondState: State!
    var resetState: State!
    
    var currentState: State!
    
    init() {
        checkFirstState = CheckFirst(checkSignals: self)
        restState = Rest(checkSignals: self)
        checkSecondState = CheckSecond(checkSignals: self)
        resetState = Reset(checkSignals: self)
        currentState = checkFirstState
    }
    
    func insertSignal(sgn: Int) {
        currentState.inputSignal(sgn: sgn)
    }
    
    func Do() {
        // Main 동작
        while !(signals as String).isEmpty {
            let sgn = Int(String(Character(UnicodeScalar(signals.character(at: 0))!)))!
            currentState.inputSignal(sgn: sgn)
            signals = signals.substring(from: 1) as NSString
            sleep(1)
        }
        print("Check End")
    }
    
    // MARK:- methods
    func setState(state: State) {
        currentState = state
    }
    
    func getCheckFirstState() -> State {
        return checkFirstState!
    }
    
    func getRestState() -> State {
        return restState!
    }
    
    func getCheckSecondState() -> State {
        return checkSecondState!
    }
    
    func getResetState() -> State {
        return resetState!
    }
}

let checkMachine = CheckSignals()
checkMachine.Do()

//func getSignal(signal: NSString) -> Int? {
//    let sign = Character(UnicodeScalar(signal.character(at: 0))!)
//    return Int(String(sign))
//}
//
//var threshold = 3
//var sec = 0
//var errorcount = 0
//var sign1 = "555250055545555557555525557555522345532235673665432" as NSString
//var sign2 = "555557555525"
//
//enum State {
//    case CHECK_5SEC_FIRST
//    case CHECK_5SEC_SECOND
//    case REST_2SEC
//    case OFF_10SEC
//    case COMPLETE
//}
//
//var state: State = .CHECK_5SEC_FIRST
//while true {
//    print("signal : \(sign1)")
//    if (sign1 as String).isEmpty {
//        state = .COMPLETE
//        continue
//    }
//
//    let sgn = getSignal(signal: sign1)!
//    if state == .CHECK_5SEC_FIRST {             // 5초 카운트
//        if sec < 5 {
//            if sgn < threshold {
//                sec = 0
//                errorcount = 0
//                print("Signal \(sgn) : OK")
//            } else {
//                sec += 1
//                print("Signal \(sgn) : OVER - \(sec)")
//            }
//            sign1 = sign1.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state = .REST_2SEC
//            sec = 0
//        }
//    } else if state == .REST_2SEC {      // 2초 휴식
//        if sec < 2 {
//            sec += 1
//            print("Signal \(sgn) : RESET - \(sec)")
//            sign1 = sign1.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state = .CHECK_5SEC_SECOND
//            sec = 0
//            errorcount += 1
//        }
//    } else if state == .CHECK_5SEC_SECOND {
//        if sec < 5 {
//            if sgn < threshold {
//                sec = 0
//                errorcount = 0
//                print("Signal \(sgn) : OK")
//                state = .CHECK_5SEC_FIRST
//            } else {
//                sec += 1
//                print("Signal \(sgn) : OVER - \(sec)")
//            }
//            sign1 = sign1.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state = .OFF_10SEC
//            sec = 0
//        }
//    } else if state == .OFF_10SEC {      // Power Off
//        if sec < 10 {
//            sec += 1
//            print("Power Off... - \(sec)")
//            sleep(1)
//        } else {
//            state = .CHECK_5SEC_FIRST
//            sec = 0
//            errorcount = 0
//        }
//    } else if state == .COMPLETE {
//        print("COMPLETE")
//        break
//    }
//}
//print("Signal End")
