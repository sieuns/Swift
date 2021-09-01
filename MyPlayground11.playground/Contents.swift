/* 익스텐션을 통한 연산 프로퍼티 추가 */
//Int타입에 두 개의 연산 프로퍼티 추가
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return self % 2 == 1
    }
}

print(1.isEven)
print(2.isEven)
print(1.isOdd)
print(2.isOdd)

var number: Int = 3
print(number.isEven)
print(number.isOdd)

number = 2
print(number.isEven)
print(number.isOdd)

/* 익스텐션을 통한 메서드 추가 */
extension Int {
    func multiply(by n: Int) -> Int {
        return self * n
    }
    
    mutating func multiplySelf(by n: Int) {
        self = self.multiply(by: n)
    }
    
    static func isIntTypeInstance(_ instance: Any) -> Bool {
        return instance is Int
    }
}

print(3.multiply(by: 2))
print(4.multiply(by: 5))

var number2: Int = 3

number2.multiply(by: 2)
print(number2)

number2.multiply(by: 3)
print(number2)

Int.isIntTypeInstance(number2)
Int.isIntTypeInstance(3)
Int.isIntTypeInstance(3.0)
Int.isIntTypeInstance("3")

/* 익스텐션을 통한 이니셜라이저 추가 */
extension String {
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }
    
    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }
}

let stringFromInt: String = String(intTypeNumber: 100)
let stringFromDouble: String = String(doubleTypeNumber: 100.0)

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Person {
    convenience init() {
        self.init(name: "Unknown")
    }
}

let someOne: Person = Person()
print(someOne.name)

/* 익스텐션을 통한 초기화 위임 이니셜라이저 추가 */
struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Rect {
    var origin: Point = Point()
    var size: Size = Size()
}

let defaultRect: Rect = Rect()
let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX: Double = center.x - (size.width / 2)
        let originY: Double = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect: Rect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
