import UIKit
import Foundation

/* State pattern
 * 1. 두 신호는 5초 검사 - 2초 대기 - 10초 검사 - shutdown system에서 검사
 * 2. 신호 A가 5초동안 threshold 아래로 떨어지지 않으면 신호 B는 10초 검사구간 C에 돌입
 * 3. 검사구간 C에서 threshold를 넘는 신호가 2회 연속 나타나면 A와 B 모두 shutdown
 * 4. 신호 B의 경우 반대로 같은 동작
 * 5. 검사중 한번이라도 threshold보다 낮은 신호가 들어오면 처음부터 재시작
 * 6. 신호 A, B가 처음 5초동안 threshold 아래로 내려가지 못하면 둘다 검사구간 C에 돌입, 종료조건 같음
 * 7. 일반 10초 검사구간 D에서 10초가 지나도록 threshold를 내려가지 못하면 둘다 shutdown
 */

/* States
 * State A : Tx, Rx 모두 5초 검사
 * State B : Tx는 2초 대기, Rx는 에러검사
 * State C : Tx는 10초 검사, Rx는 에러검사
 * State D : Tx는 에러검사, Rx는 2초 대기
 * State E : Tx는 에러검사, Rx는 10초 검사
 * State F : Tx, Rx 모두 에러검사
 * State G : ShutDown
 */
var threshold = 3
var txCount = 0
var rxCount = 0
var signal1 = "555250055545555557555525557555522345532235673665432" as NSString
var signal2 = "533335005554555555755552555755549734875738673665432" as NSString
var powerOn = true

protocol State {
    // functions
    func inputSignal(tx: Int, rx: Int)
}

class StateA: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        if tx > threshold {
            print("CheckTx : OVER - \(tx)")
            txCount += 1
        } else {
            print("CheckTx: OK - \(tx)")
            txCount = 0
        }
        
        if rx > threshold {
            print("CheckRx: OVER - \(rx)")
            rxCount += 1
        } else {
            print("CheckRx: OK - \(rx)")
            rxCount = 0
        }
        
        if txCount == 5 && rxCount == 5{
            checkSignals.setState(state: checkSignals.getStateF())
            txCount = 0
            rxCount = 0
        } else if txCount == 5 {
            checkSignals.setState(state: checkSignals.getStateB())
            txCount = 0
            rxCount = 0
        } else if rxCount == 5 {
            checkSignals.setState(state: checkSignals.getStateD())
            txCount = 0
            rxCount = 0
        }
    }
}

class StateB: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        if tx > threshold {
            print("RestTx : OVER - \(tx)")
            txCount += 1
        } else {
            print("RestTx: OK - \(tx)")
            txCount = 0
        }
        
        if rx > threshold {
            print("ErrorRx: OVER - \(rx)")
            rxCount += 1
        } else {
            print("ErrorRx: OK - \(rx)")
            rxCount = 0
        }
        
        if rxCount == 2 {
            checkSignals.setState(state: checkSignals.getStateG())
            txCount = 0
            rxCount = 0
        } else if txCount == 2 {
            checkSignals.setState(state: checkSignals.getStateC())
            txCount = 0
            rxCount = 0
        }
    }
}

class StateC: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        if tx > threshold {
            print("CheckTx : OVER - \(tx)")
            txCount += 1
        } else {
            print("CheckTx: OK - \(tx)")
            txCount = 0
        }
        
        if rx > threshold {
            print("ErrorRx: OVER - \(rx)")
            rxCount += 1
        } else {
            print("ErrorRx: OK - \(rx)")
            rxCount = 0
        }
        
        if txCount == 10 || rxCount == 2 {
            checkSignals.setState(state: checkSignals.getStateG())
            txCount = 0
            rxCount = 0
        }
    }
}

class StateD: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        if tx > threshold {
            print("ErrorTx : OVER - \(tx)")
            txCount += 1
        } else {
            print("ErrorTx: OK - \(tx)")
            txCount = 0
        }
        
        if rx > threshold {
            print("RestRx: OVER - \(rx)")
            rxCount += 1
        } else {
            print("RestRx: OK - \(rx)")
            rxCount = 0
        }
        
        if txCount == 2 {
            checkSignals.setState(state: checkSignals.getStateG())
            txCount = 0
            rxCount = 0
        } else if rxCount == 2 {
            checkSignals.setState(state: checkSignals.getStateE())
            txCount = 0
            rxCount = 0
        }
    }
}

class StateE: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        if tx > threshold {
            print("ErrorTx : OVER - \(tx)")
            txCount += 1
        } else {
            print("ErrorTx: OK - \(tx)")
            txCount = 0
        }
        
        if rx > threshold {
            print("CheckRx: OVER - \(rx)")
            rxCount += 1
        } else {
            print("CheckRx: OK - \(rx)")
            rxCount = 0
        }
        
        if txCount == 2 || rxCount == 10 {
            checkSignals.setState(state: checkSignals.getStateG())
            txCount = 0
            rxCount = 0
        }
    }
}

class StateF: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        if tx > threshold {
            print("ErrorTx : OVER - \(tx)")
            txCount += 1
        } else {
            print("ErrorRx: OK - \(tx)")
            txCount = 0
        }
        
        if rx > threshold {
            print("ErrorRx: OVER - \(rx)")
            rxCount += 1
        } else {
            print("ErrorRx: OK - \(rx)")
            rxCount = 0
        }
        
        if txCount == 2 || rxCount == 2 {
            checkSignals.setState(state: checkSignals.getStateG())
            txCount = 0
        }
    }
}

class StateG: State {
    var checkSignals: CheckSignals
    
    init(checkSignals: CheckSignals) {
        self.checkSignals = checkSignals
    }
    
    func inputSignal(tx: Int, rx: Int) {
        print("SHUT DOWN")
        powerOn = false
    }
}

class CheckSignals {
    var stateA: State!
    var stateB: State!
    var stateC: State!
    var stateD: State!
    var stateE: State!
    var stateF: State!
    var stateG: State!
    
    var currentState: State!
    
    init() {
        stateA = StateA(checkSignals: self)
        stateB = StateB(checkSignals: self)
        stateC = StateC(checkSignals: self)
        stateD = StateD(checkSignals: self)
        stateE = StateE(checkSignals: self)
        stateF = StateF(checkSignals: self)
        stateG = StateG(checkSignals: self)
        currentState = stateA
    }
    
    func insertSignal(tx: Int, rx: Int) {
        currentState.inputSignal(tx: tx, rx: rx)
    }
    
    func Do() {
        // Main 동작
        while !(signal1 as String).isEmpty || !(signal2 as String).isEmpty {
            let tx = Int(String(Character(UnicodeScalar(signal1.character(at: 0))!)))!
            let rx = Int(String(Character(UnicodeScalar(signal2.character(at: 0))!)))!
            currentState.inputSignal(tx: tx, rx: rx)
            if !powerOn {
                break
            }
            signal1 = signal1.substring(from: 1) as NSString
            signal2 = signal2.substring(from: 1) as NSString
            sleep(1)
        }
        print("Check End")
    }
    
    // MARK:- methods
    func setState(state: State) {
        currentState = state
    }
    
    func getStateA() -> State {
        return stateA!
    }
    
    func getStateB() -> State {
        return stateB!
    }
    
    func getStateC() -> State {
        return stateC!
    }
    
    func getStateD() -> State {
        return stateD!
    }
    
    func getStateE() -> State {
        return stateE!
    }
    
    func getStateF() -> State {
        return stateF!
    }
    
    func getStateG() -> State {
        return stateG!
    }
}

let checkMachine = CheckSignals()
checkMachine.Do()


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
