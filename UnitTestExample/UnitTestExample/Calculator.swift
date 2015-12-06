import UIKit

class Calculator: NSObject {
    
    var result: Int = 0
    
    static func add(a: Int, b: Int) -> Int {
        return a+b
    }
    
    func add(a: Int) {
        result = Calculator.add(result, b: a)
    }

}
