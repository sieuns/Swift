/*
 맵
 */
/*for-in 구문과 맵 메서드의 사용 비교*/

let numbers: [Int] = [0,1,2,3,4]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

//for 구문
for number in numbers {
    doubledNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubledNumbers)
print(strings)

//map 메서드
doubledNumbers = numbers.map({ (number: Int) -> Int in
        return number * 2
})
strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubledNumbers)
print(strings)

/*다양한 컨테이너 타입에서의 맵의 활용*/
let alphabetDictionary: [String: String] = ["a":"A", "b":"B"]

var keys: [String] = alphabetDictionary.map { (tuple: (String,String)) ->
    String in
    return tuple.0
}

keys = alphabetDictionary.map{ $0.0 }

let values: [String] = alphabetDictionary.map{ $0.1 }
print(keys)
print(values)

var numberSet: Set<Int> = [1,2,3,4,5]
let resultSet = numberSet.map{ $0 * 2}
//print(resultInt)

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map{ $0 * 2 }
print(resultRange)

/*필터 메서드의 사용*/
let numbers1: [Int] = [0,1,2,3,4,5]

let evenNumbers: [Int] = numbers.filter{ (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)

let oddNumbers: [Int] = numbers.filter{ $0 % 2 == 1}
print(oddNumbers)

/*리듀스 메서드의 사용*/
let numbers2: [Int] = [1,2,3]

//reduce(_:_:) 메서드 사용

//초기값이 0이고 정수 배열의 모든 값을 더한다.
var sum: Int = numbers2.reduce(0, { (result: Int, next: Int) -> Int in
    print("\(result) + \(next)")
    return result + next
})

print(sum)

//초기값이 3이고 정수 배열의 모든 값을 더한다.
let sumFromThree: Int = numbers2.reduce(3){
    print("\($0) + \($1)")
    return $0 + $1
}

print(sumFromThree)

//문자열 배열을 reduce(_:_:) 메서드를 이용해 연결시킨다.
let names: [String] = ["Chope","Jay","Joker","Nova"]

let reducedNames: String = names.reduce("sieun's friend: "){
    return $0 + ", " + $1
}

print(reducedNames)

//reduce(into:_:) 메서드 사용

//초기값이 0이고 정수 배열의 모든 값을 더한다.
sum = numbers2.reduce(into: 0,{ (result: inout Int, next: Int) in
    print("(result) + \(next)")
    result += next
})

print(sum)

//이름을 모두 대문자로 변환하여 초깃값인 빈 배열에 직접 연산
var upperCasedNames: [String]
upperCasedNames = names.reduce(into:[],{
    $0.append($1.uppercased())
})

print(upperCasedNames)

//맵을 사용한 모습
upperCasedNames = names.map{ $0.uppercased()}
print(upperCasedNames)

/*맵,필터,리듀스의 활용*/

//친구들의 정보 생성
enum Gender {
    case male, female, unknowm
}

struct Friend {
    let name: String
    let gender: Gender
    var location: String
    var age: Int
}

var friends: [Friend] = [Friend]()

friends.append(Friend(name: "sejung", gender: .female, location: "둔촌동", age: 21))
friends.append(Friend(name: "haeun", gender: .female, location: "미사", age: 20))
friends.append(Friend(name: "siyeon", gender: .female, location: "덕풍동", age: 23))
friends.append(Friend(name: "sihyeong", gender: .male, location: "오륜동", age: 17))
friends.append(Friend(name: "jeongyeol", gender: .male, location: "덕풍동", age: 53 ))
friends.append(Friend(name: "bogyeong", gender: .female, location: "오륜동", age: 50 ))

//미사 외의 지역에 거주하며 25세 이상인 친구
var result: [Friend] = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }

result = result.filter{ $0.location != "미사" && $0.age >= 25 }

let string: String = result.reduce("미사 외의 지역에 거주하며 25세 이상인 친구"){
    $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세" }

print(string)
