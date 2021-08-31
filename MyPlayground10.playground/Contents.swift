/* 프로퍼티 요구 */
protocol SomeProtocol {
    var settableProperty: String { get set }
    var notNeedToBeSettable: String { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
    static var anotherTypeProperty: Int { get }
}

/* Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스 */
protocol Sendable {
    var from: String { get }
    var to: String { get }
}

class Message: Sendable {
    var sender: String
    var from: String { // 읽기 전용
        return self.sender
    }
    
    var to: String
    
    init(sender: String, receiver: String) {
        self.sender = sender
        self.to = receiver
    }
}

class Mail: Sendable {
    var from: String // 읽고 쓰기 가능
    var to: String
    
    init(sender: String, receiver: String) {
        self.from = sender
        self.to = receiver
    }
}

/* Receiveable, Sendable 프로토콜과 두 프로토콜을 준수하는 Message와 Mail 클래스 */
// 무언가를 수신받을 수 있는 기능
protocol Receiveable2 {
    func received(data: Any, from: Sendable2)
}

// 무언가를 발신할 수 있는 기능
protocol Sendable2 {
    var from: Sendable2 { get }
    var to: Receiveable2? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}


class Message2: Sendable2, Receiveable2 {
    // 발신은 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 함
    var from: Sendable2 {
        return self
    }
    
    // 상대방은 수신 가능한 객체, 즉 Receivable 프로토콜을 준수하는 타입의 인스턴스여야 함
    var to: Receiveable2?
    
    // 메시지를 발신
    func send(data: Any) {
        guard let receiver: Receiveable2 = self.to else {
            print("Message has no receiver")
            return
        }
        
        // 수신 가능한 인스턴스의 received 메서드 호출
        receiver.received(data: data, from: self.from)
    }
    
    // 메시지를 수신
    func received(data: Any, from: Sendable2) {
        print("Message received \(data) from \(from)")
    }
    
    // class 메서드이므로 상속이 가능
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        
        return false
    }
}

// 수신, 발신이 가능한 Mail 클래스
class Mail2: Sendable2, Receiveable2 {
    var from: Sendable2 {
        return self
    }
    
    var to: Receiveable2?
    
    func send(data: Any) {
        guard let receiver: Receiveable2 = self.to else {
            print("Mail has no received")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable2) {
        print("Mail received \(data) from \(from)")
    }
    
    // static 메서드이므로 상속이 불가능
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        
        return false
    }
}

// 두 Message 인스턴스 생성
let myPhoneMessage: Message2 = Message2()
let yourPhoneMessage: Message2 = Message2()

myPhoneMessage.send(data: "Hello")

myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

// 두 Mail 인스턴스 생성
let myMail: Mail2 = Mail2()
let yourMail: Mail2 = Mail2()

myMail.send(data: "Hi")
myMail.to = yourMail
myMail.send(data: "Hi")

// Mail과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고받을 수 있다
myMail.to = myPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable 프로토콜을 준수하지 않음
print(Message2.isSendableInstance("Hello"))
print(Message2.isSendableInstance(myPhoneMessage))

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없음
print(Message2.isSendableInstance(yourPhoneMessage))
print(Mail2.isSendableInstance(myPhoneMessage))
print(Mail2.isSendableInstance(myMail))

/* Resettable 프로토콜의 가변 메서드 요구 */
protocol Resettable {
    mutating func reset()
}

class Person: Resettable {
    var name: String?
    var age: Int?
    
    func reset() {
        self.name = nil
        self.age = nil
    }
}

struct Point: Resettable {
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction: Resettable {
    case east, west, south, north, unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}

/* 프로토콜의 이니셜라이저 요구 */
protocol Named {
    var name: String { get }
    
    init(name: String)
}

//구조체의 이니셜라이저 요구 구현
struct Pet: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//클래스의 이니셜라이저 요구 구현
class Student: Named {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

//상속 불가능한 클래스의 이니셜라이저 요구 구현
final class People: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

//상속받은 클래스의 이니셜라이저 요구 구현 및 재정의
class School {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class MiddleSchool: School, Named {
    required override init(name: String) {
        super.init(name: name)
    }
}

//실패 가능한 이니셜라이저 요구를 포함하는 Named 프로토콜과 Named 프로토콜을 준수하는 다양한 타입들
protocol Named2 {
    var name: String { get }
    
    init?(name: String)
}

struct Animal: Named2 {
    var name: String
    
    init!(name: String) {
        self.name = name
    }
}

struct Pet2: Named2 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Person2: Named2 {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class School2: Named2 {
    var name: String
    
    required init? (name: String) {
        self.name = name
    }
}

//프로토콜 타입 변수
var someNamed: Named2 = Animal(name: "Animal")
someNamed = Pet2(name: "Pet")
someNamed = Person2(name: "Person")
someNamed = School2(name: "School")!

/* 프로토콜의 상속 */
protocol Readable {
    func read()
}

protocol Writeable {
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

class SomeClass: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    
    func write() {
        print("Write")
    }
    
    func speak() {
        print("Speak")
    }
}

/* 클래스 전용 프로토콜의 정의 */
protocol ClassOnlyProtocol: class, Readable, Writeable {
    // 추가 요구사항
}

class SomeClass2: ClassOnlyProtocol {
    func read() { }
    func write() { }
}

// 오류! ClassOnlyProtocol 프로토콜은 클래스 타입에만 채택 가능
/* struct SomeStruct: ClassOnlyProtocol {
    func read() { }
    func write() { }
} */

/* 프로토콜 조합 및 프로토콜, 클래스 조합 */
protocol Named3 {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person3: Named3, Aged {
    var name: String
    var age: Int
}

class Car: Named3 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Truck: Car, Aged {
    var age: Int
    
    init(name: String, age: Int) {
        self.age = age
        super.init(name: name)
    }
}

func celebrateBirthday(to celebrator: Named3 & Aged) {
    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let yagom: Person3 = Person3(name: "yagom", age: 99)
celebrateBirthday(to: yagom)

let myCar: Car = Car(name: "Boong Boong")

// 오류 ! Aged를 충족하지 않음
//celebrateBirthday(to: myCar)

// 클래스 & 프로토콜 조합에서는 클래스 타입은 한 타입만 가능
//var someVariable: Car & Truck & Aged

var someVariable: Car & Aged
someVariable = Truck(name: "Truck", age: 5)

someVariable = Truck(name: "Tuesday", age: 123)

// Aged프로토콜을 충족하지 않음
//someVariable = myCar

/* 프로토콜 확인 및 캐스팅 */
print(yagom is Named)
print(yagom is Aged)

print(myCar is Named)
print(myCar is Aged)

if let castedInstance: Named = yagom as? Named {
    print("\(castedInstance) is Named")
}

if let castedInstance: Aged = yagom as? Aged {
    print("\(castedInstance) is Aged")
}

if let castedInstance: Named = myCar as? Named {
    print("\(castedInstance) is Named")
}


if let castedInstance: Aged = myCar as? Aged {
    print("\(castedInstance) is Aged")
} // 출력 없음 캐스팅 실패

/* 프로토콜의 선택적 요구 */
import Foundation

@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

// 걷기만 할 수 있는 호랑이
class Tiger: NSObject, Moveable {
    func walk() {
        print("Tiger walks")
    }
}

// 걷고 날 수 있는 새
class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }
    
    func fly() {
        print("Bird flys")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()
bird.walk()

bird.fly()

var moveableInstance: Moveable = tiger
moveableInstance.fly?()

moveableInstance = bird
moveableInstance.fly?()
