import Foundation

func task10b() {
    let path = "./10.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    class Position : CustomStringConvertible {
        let row, column, height: Int
        var discoveredPositions: [Position] = []

        init(row: Int, column: Int, height: Int) {
            self.row = row
            self.column = column
            self.height = height
        }

        var description: String {
            if height == 0 {
                return "(\(column), \(row)) \(height) - \(discoveredPositions.count)"
            } else {
                return "(\(column), \(row)) \(height)"
            }
        }
    }

    func doTask(lines: [String]) {
        var positions: [[Position]] = []
        for (rowIndex, row) in lines.enumerated() {
            var rowPositions: [Position] = []
            for (colIndex, heightChar) in row.enumerated() {
                rowPositions.append(Position(row: rowIndex,  column: colIndex, height: Int("\(heightChar)")!))
            }
            positions.append(rowPositions)
        }

        func neighbors(_ pos: Position) -> [Position] {
            var neighbors: [Position] = []
            if pos.row > 0 {
                neighbors.append(positions[pos.row - 1][pos.column])
            }
            if pos.row < positions.count - 1 {
                neighbors.append(positions[pos.row + 1][pos.column])
            }
            if pos.column > 0 {
                neighbors.append(positions[pos.row][pos.column - 1])
            }
            if pos.column < positions[pos.row].count - 1 {
                neighbors.append(positions[pos.row][pos.column + 1])
            }
            return neighbors
        }

        let endPositions = positions.flatMap { $0 }.filter { $0.height == 9 }
        for endPosition in endPositions {
            var discoveredPositions = [endPosition]
            while !discoveredPositions.isEmpty {
                let next = discoveredPositions.removeFirst()
                next.discoveredPositions.append(endPosition)
                discoveredPositions.append(contentsOf: neighbors(next).filter { $0.height == next.height - 1 })
            }
        }
        print(positions.flatMap { $0 }.filter { $0.height == 0 }.map { $0.discoveredPositions.count }.reduce(0, +))
    }
}
