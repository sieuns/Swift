class Account{
    var credit:Int = 0{
        willSet{
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다. ")
        }
        didSet{
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다. ")
        }
    }
    
    var dollarValue:Double{
        get{
            return Double(credit) / 1000.0
        }
        
        set{
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다. ")
        }
    }
}

class ForeignAccount: Account{
    override var dollarValue: Double{
        willSet{
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러으로 변경될 예정입니다. ")
        }
        didSet{
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러으로 변경되었습니다. ")
        }
    }
}

let myAccount: ForeignAccount = ForeignAccount()

myAccount.credit = 1000

myAccount.dollarValue = 2

var wonInPocket: Int = 2000

class AClass{
    
    //저장 타입 프로퍼티
    static var typeProperty:Int = 0
    
    //저장 인스턴스 프로퍼티
    var instanceProperty:Int = 0 {
        didSet{
            Self.typeProperty = instanceProperty + 100
        }
    }
    
    //연산 타입 프로퍼티
    static var typeComputedProperty:Int {
        get{
            return typeProperty
        }
        set{
            typeProperty = newValue
        }
    }
}

AClass.typeProperty = 123

let classInstance:AClass = AClass()
classInstance.instanceProperty = 100

print(AClass.typeProperty)
print(AClass.typeComputedProperty)

//KeyPath 서브스크립트와 키 경로 활용
class Person{
    let name:String
    init(name:String){
        self.name = name
    }
}

struct Stuff{
    var name:String
    var owner:Person
}

let yagom = Person(name:"yagom")
let hana = Person(name:"hana")
let macbook = Stuff(name:"MacBook Pro",owner : yagom)
var iMac = Stuff(name: "iMac", owner: yagom)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerkeyPath = \Stuff.owner
let ownerNameKeyPath = ownerkeyPath.appending(path: \.name)

print(macbook[keyPath: stuffNameKeyPath])
print(iMac[keyPath: stuffNameKeyPath])
print(iPhone[keyPath: stuffNameKeyPath])

print(macbook[keyPath: ownerNameKeyPath])
print(iMac[keyPath: ownerNameKeyPath])
print(iPhone[keyPath: ownerNameKeyPath])

iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerkeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath])
print(iMac[keyPath: ownerkeyPath])

//상수로 지정한 값 타입과 읽기 전용 프로퍼티는 키 경로 서브스크립트로 값 변경 불가능
//macbook[keyPath: stuffNamePath] = "macbook pro touch bar"    //오류
//yagom[keyPath:\Person.name] = "bear" //오류

// self프로퍼티와 mutating 키워드
class LevelClass{
    var level:Int = 0
    
    func reset()
    {
        //오류!! self 프로퍼티 참조 변경 불가!
        //self = LevelClass()
    }
}
struct LevelStruct{
    var level:Int = 0
    
    mutating func levelUp(){
        print("Level up!")
        level += 1
    }
    mutating func reset(){
        print("Reset!")
        self = LevelStruct()
    }
}

var levelStructInstance:LevelStruct = LevelStruct()
levelStructInstance.levelUp()
print(levelStructInstance.level)

levelStructInstance.reset()
print(levelStructInstance.level)

enum OnOffSwitch{
    case on,off
    mutating func nextState(){
        self = self == .on ? .off : .on
    }
}

var toggle:OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle)
