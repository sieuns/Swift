/* 전위 연산자 구현과 사용 */
prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)

/* 프로토콜과 제네릭을 이용한 전위 연산자 구현과 사용 */
prefix operator **

prefix func ** <T: BinaryInteger> (value: T) -> T {
    return value * value
}

let minusFive2 = -5
let five: UInt = 5

let sqrtMinusFive2: Int = **minusFive
let sqrtFive: UInt = **five

print(sqrtFive)
print(sqrtMinusFive)
