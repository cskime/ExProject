import UIKit
import Foundation

/* Non State Pattern */
//func getSignal(signal: NSString) -> Int? {
//    let sign = Character(UnicodeScalar(signal.character(at: 0))!)
//    return Int(String(sign))
//}
//
//var threshold = 3
//var count_Tx = 0
//var count_Rx = 0
//var errorcount_Tx = 0
//var errorcount_Rx = 0
//var signal_Tx = "555250055545555557555525557555522345532235673665432" as NSString
//var signal_Rx = "533335005554555555755552555755549734875738673665432" as NSString
//var offTx = false
//var offRx = false
//
//enum State {
//    case TX_CHECK_5SEC_FIRST
//    case TX_CHECK_10SEC_SECOND
//    case TX_REST_2SEC
//    case TX_CHECK_10SEC_ERROR
//    case RX_CHECK_5SEC_FIRST
//    case RX_CHECK_10SEC_SECOND
//    case RX_REST_2SEC
//    case RX_CHECK_10SEC_ERROR
//    case COMPLETE
//}
//
//var state_Tx: State = .TX_CHECK_5SEC_FIRST
//var state_Rx: State = .RX_CHECK_5SEC_FIRST
//while true {
//    if (signal_Tx as String).isEmpty || (signal_Rx as String).isEmpty {
//        state_Tx = .COMPLETE
//        state_Rx = .COMPLETE
//        continue
//    }
//
//    let sgn_Tx = getSignal(signal: signal_Tx)!
//    if state_Tx == .TX_CHECK_5SEC_FIRST {             // 5초 카운트
//        if count_Tx < 5 {
//            if sgn_Tx < threshold {
//                count_Tx = 0
//                print("Signal_Tx \(sgn_Tx) : OK")
//            } else {
//                count_Tx += 1
//                print("Signal_Tx \(sgn_Tx) : OVER - \(count_Tx)")
//            }
//
//            sleep(1)
//            signal_Tx = signal_Tx.substring(from: 1) as NSString
//        } else {
//            state_Tx = .TX_REST_2SEC
//            count_Tx = 0
//            state_Rx = .RX_CHECK_10SEC_ERROR
//            count_Rx = 0
//        }
//    } else if state_Tx == .TX_REST_2SEC {      // 2초 휴식
//        if count_Tx < 2 {
//            count_Tx += 1
//            print("Signal_Tx \(sgn_Tx) : RESET - \(count_Tx)")
//            signal_Tx = signal_Tx.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state_Tx = .TX_CHECK_10SEC_ERROR
//            count_Tx = 0
//        }
//    } else if state_Tx == .TX_CHECK_10SEC_ERROR {
//        if count_Tx < 10 {
//            if sgn_Tx < threshold {
//                count_Tx = 0
//                print("Signal_Tx \(sgn_Tx) : OK")
//            } else {
//                count_Tx += 1
//                print("Signal_Tx \(sgn_Tx) : OVER - \(count_Tx)")
//            }
//
//            if count_Tx > 2 {
//                state_Tx = .COMPLETE
//                continue
//            }
//
//            signal_Tx = signal_Tx.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state_Tx = .COMPLETE
//            count_Tx = 0
//            state_Rx = .COMPLETE
//            count_Rx = 0
//        }
//    } else if state_Tx == .COMPLETE {
//        print("COMPLETE_Tx")
//        break
//    }
//
//
//    let sgn_Rx = getSignal(signal: signal_Rx)!
//    if state_Rx == .RX_CHECK_5SEC_FIRST {             // 5초 카운트
//        if count_Rx < 5 {
//            if sgn_Rx < threshold {
//                count_Rx = 0
//                errorcount_Rx = 0
//                print("Signal_Rx \(sgn_Rx) : OK")
//            } else {
//                count_Rx += 1
//                print("Signal-Rx \(sgn_Rx) : OVER - \(count_Rx)")
//            }
//            sleep(1)
//            signal_Rx = signal_Rx.substring(from: 1) as NSString
//        } else {
//            state_Rx = .RX_REST_2SEC
//            count_Rx = 0
//            state_Tx = .TX_CHECK_10SEC_ERROR
//            count_Tx = 0
//        }
//    } else if state_Rx == .RX_REST_2SEC {      // 2초 휴식
//        if count_Rx < 2 {
//            count_Rx += 1
//            print("Signal_Rx \(sgn_Rx) : RESET - \(count_Rx)")
//            signal_Rx = signal_Rx.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state_Rx = .RX_CHECK_10SEC_SECOND
//            count_Rx = 0
//            errorcount_Rx += 1
//        }
//    } else if state_Rx == .RX_CHECK_10SEC_SECOND {
//        if count_Rx > 2 {
//            state_Rx = .COMPLETE
//            continue
//        }
//
//        if count_Rx < 10 {
//            if sgn_Rx < threshold {
//                count_Rx = 0
//                print("Signal_Rx \(sgn_Rx) : OK")
//            } else {
//                count_Rx += 1
//                print("Signal_Rx \(sgn_Rx) : OVER - \(count_Rx)")
//            }
//
//            signal_Rx = signal_Rx.substring(from: 1) as NSString
//            sleep(1)
//        } else {
//            state_Rx = .COMPLETE
//            count_Rx = 0
//            state_Tx = .COMPLETE
//            count_Tx = 0
//        }
//    } else if state_Rx == .COMPLETE {
//        print("COMPLETE_Rx")
//        break
//    }
//    print("")
//}
//print("Signal End")


/* State pattern */
//var threshold = 3
//var count = 0
//var signal1 = "555250055545555557555525557555522345532235673665432" as NSString
//var signal2 = "533335005554555555755552555755549734875738673665432" as NSString
//protocol State {
//    // functions
//    func inputSignal(sgn: Int)
//}
//
//class CheckFirst: State {
//    var checkSignals: CheckSignals
//
//    init(checkSignals: CheckSignals) {
//        self.checkSignals = checkSignals
//    }
//
//    func inputSignal(sgn: Int) {
//        if sgn > threshold {
//            print("Check1 : OVER - \(sgn)")
//            count += 1
//        } else {
//            print("Check1: OK - \(sgn)")
//            count = 0
//        }
//
//        if count == 5 {
//            checkSignals.setState(state: checkSignals.getRestState())
//            count = 0
//        }
//    }
//}
//
//class Rest: State {
//    var checkSignals: CheckSignals
//
//    init(checkSignals: CheckSignals) {
//        self.checkSignals = checkSignals
//    }
//
//    func inputSignal(sgn: Int) {
//        print("Rest : \(sgn)")
//        count += 1
//
//        if count == 2 {
//            checkSignals.setState(state: checkSignals.getCheckSecondState())
//            count = 0
//        }
//    }
//}
//
//class CheckSecond: State {
//    var checkSignals: CheckSignals
//
//    init(checkSignals: CheckSignals) {
//        self.checkSignals = checkSignals
//    }
//
//    func inputSignal(sgn: Int) {
//        if sgn > threshold {
//            print("Check2 : OVER - \(sgn)")
//            count += 1
//        } else {
//            print("Check2: OK - \(sgn)")
//            checkSignals.setState(state: checkSignals.getCheckFirstState())
//            count = 0
//        }
//
//        if count == 5 {
//            checkSignals.setState(state: checkSignals.getResetState())
//            count = 0
//        }
//    }
//}
//
//class Reset: State {
//    var checkSignals: CheckSignals
//
//    init(checkSignals: CheckSignals) {
//        self.checkSignals = checkSignals
//    }
//
//    func inputSignal(sgn: Int) {
//        print("Reset")
//        count += 1
//
//        if count == 10 {
//            checkSignals.setState(state: checkSignals.getCheckFirstState())
//        }
//    }
//}
//
//class CheckSignals {
//    var checkFirstState: State!
//    var restState: State!
//    var checkSecondState: State!
//    var resetState: State!
//
//    var currentState: State!
//
//    init() {
//        checkFirstState = CheckFirst(checkSignals: self)
//        restState = Rest(checkSignals: self)
//        checkSecondState = CheckSecond(checkSignals: self)
//        resetState = Reset(checkSignals: self)
//        currentState = checkFirstState
//    }
//
//    func insertSignal(sgn: Int) {
//        currentState.inputSignal(sgn: sgn)
//    }
//
//    func Do() {
//        // Main 동작
//        while !(signals as String).isEmpty {
//            let sgn = Int(String(Character(UnicodeScalar(signals.character(at: 0))!)))!
//            currentState.inputSignal(sgn: sgn)
//            signals = signals.substring(from: 1) as NSString
//            sleep(1)
//        }
//        print("Check End")
//    }
//
//    // MARK:- methods
//    func setState(state: State) {
//        currentState = state
//    }
//
//    func getCheckFirstState() -> State {
//        return checkFirstState!
//    }
//
//    func getRestState() -> State {
//        return restState!
//    }
//
//    func getCheckSecondState() -> State {
//        return checkSecondState!
//    }
//
//    func getResetState() -> State {
//        return resetState!
//    }
//}
//
//let checkMachine = CheckSignals()
//checkMachine.Do()
