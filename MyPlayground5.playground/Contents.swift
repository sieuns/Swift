/*
 옵셔널 체이닝
*/

class Room{
    var number: Int
    
    init(number: Int){
        self.number = number
    }
}

class Building{
    var name: String
    var room: Room?
    
    init(name: String){
        self.name = name
    }
}

struct Address{
    var province: String
    var city: String
    var street: String
    var building: Building?
    var detailAddress: String?
}

class Person{
    var name: String
    var address: Address?
    
    init(name: String){
        self.name = name
    }
}

let yagom: Person = Person(name: "yagom")

let yagomRoomViaOptionalChaining: Int? = yagom.address?.building?.room?.number
//let yagomRoomViaOptionalChaining: Int = yagom.address!.building!.room!.number
//오류 발생 -> 강제 추출하여 반환하기 때문에 런타임 오류

//옵셔널 체이닝 사용
if let roomNumber: Int = yagom.address?.building?.room?.number{
    print(roomNumber)
}else{
    print("Can't not find room number")
}

//옵셔널 체이닝을 통한 값 할당
yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로", building: nil, detailAddress: nil)
yagom.address?.building = Building(name: "곰굴")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505

print(yagom.address?.building?.room?.number)

/*
 빠른 종료
 */
//guard 구문의 옵셔널 바인딩 활용
func greet(_ person: [String: String]) {
    guard let name: String = person["name"] else {
        return
    }
    
    print("Hello \(name)! ")
    
    guard let location: String = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)

personInfo["location"] = "Korea"

greet(personInfo)
