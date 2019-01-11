import UIKit
import Foundation

var threshold = 3
var sec = 0
var errorcount = 0
var sign1 = "555250055545555557555525557555522345532235673665432" as NSString
var sign2 = "555557555525"

func getSignal(signal: NSString) -> Int? {
    let sign = Character(UnicodeScalar(signal.character(at: 0))!)
    return Int(String(sign))
}


enum State {
    case CHECK_5SEC
    case REST_2SEC
    case OFF_10SEC
}

var state: State = .CHECK_5SEC
while !(sign1 as String).isEmpty {
    let sgn = getSignal(signal: sign1)!
    
    if state == .CHECK_5SEC {             // 5초 카운트
        if sec < 5 {
            if sgn < threshold {
                sec = 0
                errorcount = 0
                print("Signal \(sgn) : OK")
            } else {
                sec += 1
                print("Signal \(sgn) : OVER - \(sec)")
            }
            sign1 = sign1.substring(from: 1) as NSString
            sleep(1)
        } else {
            state = (errorcount == 1) ? .OFF_10SEC : .REST_2SEC
            sec = 0
        }
    } else if state == .REST_2SEC {      // 2초 휴식
        if sec < 2 {
            sec += 1
            print("Signal \(sgn) : RESET - \(sec)")
            sign1 = sign1.substring(from: 1) as NSString
            sleep(1)
        } else {
            state = .CHECK_5SEC
            sec = 0
            errorcount += 1
        }
    } else if state == .OFF_10SEC {      // Power Off
        if sec < 10 {
            sec += 1
            print("Power Off... - \(sec)")
            sleep(1)
        } else {
            state = .CHECK_5SEC
            sec = 0
            errorcount = 0
        }
    }
}
print("Signal End")





//while   getSignal(signal: <#T##NSString#>)
//    <#code#>if(state == 5sec_exam)   == checkcount <5 && errorciybt ==0
//    {
//        if sig> 5:
//            conout ++;
//        if count ==5:
//            state = 2sec_Rest
//        else:
//            state= 5sec_exam
//    }
//    elseif (2sec_rest)        errorcount ==0 resetcount < 2
//        {
//              power off
//             time conout ++
//            if time count ==2
//              state = 5sec_2nd_exam
//    else if(5sec_2nd_exam)      errorcount ==1 checkout< 5
//    {
//        if sig> 5:
//        conout ++;
//        if count ==5:
//            state = Error
//        else:
//            state= 5sec_exam
//        }
//    }
//state ==errorr       errorcbt == 1 checkt ==5
//   elseif
//}

//func checking(signal1: String){
//    while true {
//        // 5초 검사
//        for sec in 0..<5 {
//            let sgn = Int(String(signal1[signal1.index(signal1.startIndex, offsetBy: sec)]))!
//            print("Power On... Signal = \(sgn)")
//            if sgn < threshold {
//                ok = true
//            }
//            sleep(1)
//        }
//        count += 1
//        if ok {
//            print("OK")
//            break
//        }
//
//        // 2초 정지
//        for sec in 5..<7 {
//            let sgn = Int(String(signal1[signal1.index(signal1.startIndex, offsetBy: sec)]))!
//            print("Power Off.. Signal = \(sgn)")
//            sleep(1)
//        }
//
//        // 5초 검사
//        for sec in 7..<12 {
//            let sgn = Int(String(signal1[signal1.index(signal1.startIndex, offsetBy: sec)]))!
//            print("Power On... Signal = \(sgn)")
//            if sgn < threshold {
//                ok = true
//            }
//            sleep(1)
//        }
//        count += 1
//        if ok {
//            print("OK")
//            break
//        }
//
//        if !ok && count == 2 {
//            for _ in 0..<10 {
//                print("Error!! Power Off")
//                sleep(1)
//            }
//            count = 0
//        }
//    }
//}
//
//checking(signal1: sign2)


/*
 import UIKit
 import Foundation
 
 var threshold = 3
 var ok = false
 var checkcount = 0
 var sign1 = "555550055555" as NSString
 var sign2 = "555557555525" as NSString
 
 func getSignal(signal: NSString) -> Int {
 let sgn = Int(String(Character(UnicodeScalar(signal.character(at: 0))!)))!
 signal
 return sgn
 }
 
 // 5초 검사
 func checkSignal(signal: inout NSString) {
 var sec = 0
 while sec < 5 {
 let sgn = Int(String(Character(UnicodeScalar(signal.character(at: 0))!)))!
 print("Power On... Signal = \(sgn)")
 if sgn < threshold {
 ok = true
 }
 sleep(1)
 sec += 1
 signal = signal.substring(from: 1) as NSString
 }
 checkcount += 1
 if ok {
 print("OK")
 }
 }
 
 // 2초 정지
 func checkTerm(signal: inout NSString) {
 var sec = 0
 while sec < 2 {
 print("Power Off")
 signal = signal.substring(from: 1) as NSString
 sleep(1)
 sec += 1
 }
 }
 
 // 10초 대기
 func systemReset() {
 var sec = 0
 while sec < 10 {
 print("System Reset...")
 sleep(1)
 sec += 1
 }
 ok = false
 checkcount = 0
 }
 
 while !ok {
 checkSignal(signal: &sign2)
 
 if checkcount == 2 {
 systemReset()
 } else {
 checkTerm(signal: &sign2)
 }
 }

 */
