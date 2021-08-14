/*
 정렬을 위한 함수 전달
 */
let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

func backwards(first: String, second: String) -> Bool{
    print("\(first) \(second) 비교중 ")
    return first > second
}
let reversed: [String] = names.sorted(by: backwards)

print(reversed)

/*
 sorted(by:) 메서드에 클로저 전달
 */
let reversed2: [String] = names.sorted (by:{(first: String, second: String) -> Bool in
    return first > second
})
print(reversed)

/*
 클로저의 표현 간소화
 */
//클로저의 타입 유추, 클로저의 매개변수 타입과 반환 타입을 생략하여 표현
let reversed3: [String] = names.sorted {(first, second) in
    return first > second
}

//단축 인자 이름
let reversed4: [String] = names.sorted{
    return $0 > $1
}

//암시적 반환 표현의 사용
let reversed5: [String] = names.sorted { $0 > $1 }

/*
 함수를 탈출하는 클로저의 예
 */
typealias VoidVoidClosure = () -> Void
let firstClosure: VoidVoidClosure = {
    print("Closure A")
}
let secondClosure: VoidVoidClosure = {
    print("Closure B")
}

func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
    return shouldReturnFirstClosure ? first : second
}

let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)

returnedClosure()

var closures: [VoidVoidClosure] = []

func appendClosure(closure: @escaping VoidVoidClosure){
    closures.append(closure)
}

/*
 withoutActuallyEscaping(_:do:)함수의 활용
 */
let numbers: [Int] = [2,4,6,8]

let evenNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 0
}

let oddNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 1
}

func hasElements(in array: [Int],match predicate: (Int) -> Bool) -> Bool {
    return withoutActuallyEscaping(predicate, do: { escapablePredicate in
                                    return (array.lazy.filter{ escapablePredicate($0) }.isEmpty == false)
    })
}

let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)

print(hasEvenNumber)
print(hasOddNumber)
