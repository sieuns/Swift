//맵과 컴팩트의 차이
let optionals: [Int?] = [1,2,nil,5]

let mapped: [Int?] = optionals.map{ $0 }
let compactMapped: [Int] = optionals.compactMap{ $0 }

print(mapped)
print(compactMapped)

//중첩된 컨테이너에서 맵과 플랫맵(콤팩트맵)의 차이
let multipleContainer = [[1,2,Optional.none], [3,Optional.none], [4,5,Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap{ $0.compactMap{ $0 } }

print(mappedMultipleContainer)
print(flatmappedMultipleContainer)
