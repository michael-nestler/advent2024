import Foundation

func task06b() {
    let path = "./06.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    enum State {
        case obstacle
        case empty
        case travelled
        case watcher
    }
    
    enum Direction {
        case left, right, up, down
    }

    func doTask(lines: [String]) {
        var map: [[State]] = []
        var posRow = 0
        var posCol = 0
        for (rowIndex, line) in lines.enumerated() {
            var row: [State] = []
            for (colIndex, character) in line.enumerated() {
                var state: State = .empty
                switch character {
                    case ".": state = .empty
                    case "#": state = .obstacle
                    case "^": 
                      state = .watcher
                      posRow = rowIndex
                      posCol = colIndex
                    default: print("Invalid map character \(character)")
                }
                row.append(state)
            }
            map.append(row)
        }
        print("Starting simulation")
        var sum = 0
        for (rowIndex, row) in map.enumerated() {
            for (colIndex, col) in row.enumerated() {
                if (col == .empty) {
                    print("Attempting to place obstacle at \(rowIndex) / \(colIndex)")
                    map[rowIndex][colIndex] = .obstacle
                    let result = doSimulation(initPosRow: posRow, initPosCol: posCol, initMap: map)
                    map[rowIndex][colIndex] = .empty
                    if result {
                        sum = sum + 1
                    }
                }
            }
        }
        print(sum)
    }

    func doSimulation(initPosRow: Int, initPosCol: Int, initMap: [[State]]) -> Bool {
        var posRow = initPosRow
        var posCol = initPosCol
        var map = initMap
        var direction: Direction = .up
        var counts = map.map { Array(repeating: 0, count: $0.count) }
        while true {
            let nextRow = direction == .up ? posRow - 1 : direction == .down ? posRow + 1 : posRow
            let nextCol = direction == .left ? posCol - 1 : direction == .right ? posCol + 1 : posCol
            if nextRow < 0 || nextCol < 0 || nextRow >= map.count || nextCol >= map[nextRow].count {
                map[posRow][posCol] = .travelled
                return false
            }
            if map[nextRow][nextCol] == .obstacle {
                switch (direction) {
                    case .left: direction = .up
                    case .up: direction = .right
                    case .right: direction = .down
                    case .down: direction = .left
                }
                continue
            }
            counts[posRow][posCol] = counts[posRow][posCol] + 1
            if counts[posRow][posCol] >= 5 {
                return true
            }
            map[posRow][posCol] = .travelled
            map[nextRow][nextCol] = .watcher
            posRow = nextRow
            posCol = nextCol
        }
    }
}
