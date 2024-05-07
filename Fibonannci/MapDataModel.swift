import Foundation

class MapData {
    var index: Int
    var number: Int
    var type: DataType
    var mask: Bool
    init(index: Int, number: Int, type: DataType, mask: Bool) {
        self.index = index
        self.number = number
        self.type = type
        self.mask = mask
    }
}

enum DataType: String {
    case normal = "circle"
    case first = "mask"
    case second = "block"
}
