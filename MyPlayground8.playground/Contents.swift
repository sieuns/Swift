/* 메서드 재정의 */
class Person {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름: \(name). 나이: \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
    
    class func introduceClass() -> String {
        return "인류의 소원은 평화입니다."
    }
}

class Student: Person {
    var grade: String = "F"
    
    func study(){
        print("Study hard...")
    }
    
    override func speak() {
        print("저는 학생입니다.")
    }
}

class UniversityStudent: Student {
    var major: String = ""
    
    class func introduceClass() {
        print(super.introduceClass())
    }
    
    override class func introduceClass() -> String {
        return "대학생의 소원은 A+입니다."
    }
    
    override func speak() {
        super.speak()
        print("대학생이죠.")
    }
}

let sieun: Person = Person()
sieun.speak()

let jay: Student = Student()
jay.speak()

let jenny: UniversityStudent = UniversityStudent()
jenny.speak()

print(Person.introduceClass())
print(Student.introduceClass())
print(UniversityStudent.introduceClass() as String)
print(UniversityStudent.introduceClass() as Void)

/* 프로퍼티 재정의 */
class Person2 {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }
    
    var introduction: String{
        return "이름: \(name). 나이: \(age)"
    }
}

class Student2: Person2 {
    var grade: String = "F"
    
    override var introduction: String {
        return super.introduction + "" + "학점: \(self.grade)"
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
    }
}

let sieun2: Person2 = Person2()
sieun2.name = "sieun2"
sieun2.age = 21
//sieun2.koreanAge = 22
print(sieun2.introduction)
print(sieun2.koreanAge)

let jay2: Student2 = Student2()
jay2.name = "jay2"
jay2.age = 14
jay2.koreanAge = 15
print(jay2.introduction)
print(jay2.koreanAge)

/* 프로퍼티 감시자 재정의 */
class Person3 {
    var name: String = ""
    var age: Int = 0 {
        didSet {
            print("Person age: \(self.age)")
        }
    }
    var koreanAge: Int {
        return self.age + 1
    }
    
    var fullName: String {
        get {
            return self.name
        }
        set {
            self.name = newValue
        }
    }
}

class Student3: Person3 {
    var grade: String = "F"
    
    override var age: Int {
        didSet {
            print("Student age: \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
    }
    
    override var fullName: String {
        didSet {
            print("Full Name : \(self.fullName)")
        }
    }
}

let sieun3: Person3 = Person3()
sieun3.name = "sieun3"
sieun3.age = 22
sieun3.fullName = "Yang siuen"
print(sieun3.koreanAge)

let jay3: Student3 = Student3()
jay3.name = "jay3"
jay3.age = 14
jay3.koreanAge = 15
jay3.fullName = "Kim jay"
print(jay3.koreanAge)

/* 클래스 이니셜라이저의 재정의 */
class Person4 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 0)
    }
}

class Student4: Person4 {
    var major: String
    
    override init(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 7)
    }
}

/* 실패 가능한 이니셜라이저의 재정의 */
class Person5 {
    var name: String
    var age: Int
    
    init() {
        self.name = "Unknown"
        self.age = 0
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.age = age
    }
    
    init?(age: Int) {
        if age < 0 {
            return nil
        }
        self.name = "Unknown"
        self.age = age
    }
}

class Student5: Person5 {
    var major: String
    
    override init?(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    override init(age: Int) {
        self.major = "Swift"
        super.init()
    }
}

/* 이니셜라이저 자동 상속 */
class Person6{
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student6: Person6 {
    var major: String = "Swift"
}

//부모클래스의 지정 이니셜라이저 자동 상속
let sieun6 : Person6 = Person6(name: "sieun")
let hana: Student6 = Student6(name: "hana")
print(sieun6.name)
print(hana.name)

//부모클래스의 편의 이니셜라이저 자동 상속
let wizpaln: Person6 = Person6()
let jinSung: Student6 = Student6()
print(wizpaln.name)
print(jinSung.name)

/* 요구 이니셜라이저 재구현 */
class Person7 {
    var name: String
    
    //요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student7: Person7 {
    var major: String = "Unknown"
    
    //자신의 지정 이니셜라이저 구현
    init(major: String) {
        self.major = major
        super.init()
    }
    
    required init() {
        self.major = "Unknown"
        super.init()
    }
}

class UniversityStudent7: Student7 {
    var grade: String
    
    //자신의 지정 이니셜라이저 구현
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    required init() {
        self.grade = "F"
        super.init()
    }
}

let jiSoo: Student7 = Student7()
print(jiSoo.major)

let sieun7: Student7 = Student7(major: "Swift")
print(sieun7.major)

let juHyun: UniversityStudent7 = UniversityStudent7()
print(juHyun.grade)
