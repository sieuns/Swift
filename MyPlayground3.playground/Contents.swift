/*
 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저
 */
class SomeClass{
    init(){
        //초기화할 때 필요한 코드
    }
}
struct SomeStruct{
    init(){
        //초기화할 때 필요한 코드
    }
}
enum SomeEnum{
    case someCase
    
    init(){
        //열거형은 초기화할 떄 반드시 case중 하나가 되어야 함
        self = .someCase
        //초기화할 떄 필요한 코드
    }
}

/*
 이니셜라이저 매개변수
 */
struct Area{
    var squareMeter: Double
    
    init(fromPy py: Double){
        squareMeter = py * 3.3058
    }
    
    init(fromSquareMeter squareMeter: Double){
        self.squareMeter = squareMeter
    }
    
    init(value: Double){
        squareMeter = value
    }
    
    init(_ value: Double){
        squareMeter = value
    }
}

let roomOne: Area = Area(fromPy: 15.0)
print(roomOne.squareMeter)

let roomTwo: Area = Area(fromSquareMeter: 33.06)
print(roomTwo.squareMeter)

let roomThree: Area = Area(value: 30.0)
let roomFour: Area = Area(55.0)

/*
 실패 가능한 이니셜 라이저
 */
class Person{
    let name: String
    var age: Int?
    
    init?(name: String){
        
        if name.isEmpty{
            return nil
        }
        self.name = name
    }
    
    init?(name: String, age: Int){
        if name.isEmpty || age < 0{
            return nil
        }
        self.name = name
        self.age = age
    }
}
let yagom: Person? = Person(name: "yagom", age: 99)

if let person: Person = yagom{
    print(person.name)
}else{
    print("Person wasn't initialized")
}

let chope: Person? = Person(name: "chope", age: -10)

if let person: Person = chope{
    print(person.name)
}else{
    print("Person wasn't initialized")
}

let eric: Person? = Person(name:"",age:30)

if let person: Person = eric{
    print(person.name)
}else{
    print("Person wasn't initialized")
}

