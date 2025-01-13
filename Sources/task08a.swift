import Foundation

func task08a() {
    let path = "./08.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    func doTask(lines: [String]) {
        var antennas: [[Character?]] = []
        var frequencies: Set<Character> = []
        for line in lines {
            var row: [Character?] = []
            for freq in line {
                if freq == "." {
                    row.append(nil)
                } else {
                    row.append(freq)
                    frequencies.update(with: freq)
                }
            }
            antennas.append(row)
        }
        var antinodes: [[Bool]] = Array(repeating: Array(repeating: false, count: antennas[0].count), count: antennas.count)

        func findNextAntenna(withFrequency: Character, afterPosition: (Int, Int)) -> (Int, Int)? {
            let (afterRow, afterCol) = afterPosition
            for row in afterRow..<antennas.count {
                for col in 0..<antennas[row].count {
                    if row == afterRow && col <= afterCol {
                        continue
                    }
                    if antennas[row][col] == withFrequency {
                        return (row, col)
                    }
                }
            }
            return nil
        }

        func markAntinodes(currentPos: (Int, Int)) {
            let (currentRow, currentCol) = currentPos
            let freq = antennas[currentRow][currentCol]
            if freq == nil {
                return
            }
            var nextPos = findNextAntenna(withFrequency: freq!, afterPosition: currentPos)
            if nextPos != nil {
                markAntinodes(currentPos: nextPos!)
                while true {
                    let (nextRow, nextCol) = nextPos!
                    let (diffRow, diffCol) = (nextRow - currentRow, nextCol - currentCol)
                    let (antinodeARow, antinodeACol) = (currentRow - diffRow, currentCol - diffCol)
                    let (antinodeBRow, antinodeBCol) = (nextRow + diffRow, nextCol + diffCol)
                    //print("Current: \(currentPos), next: \(nextPos!), diff: \((diffRow, diffCol)), A: \((antinodeARow, antinodeACol)), B: \((antinodeBRow, antinodeBCol))")
                    if antinodeARow >= 0 && antinodeARow < antennas.count && antinodeACol >= 0 && antinodeACol < antennas[antinodeARow].count {
                        antinodes[antinodeARow][antinodeACol] = true
                    }
                    if antinodeBRow >= 0 && antinodeBRow < antennas.count && antinodeBCol >= 0 && antinodeBCol < antennas[antinodeBRow].count {
                        antinodes[antinodeBRow][antinodeBCol] = true
                    }
                    nextPos = findNextAntenna(withFrequency: freq!, afterPosition: nextPos!)
                    if nextPos == nil {
                        break
                    }
                }
            }
        }

        for freq in frequencies {
            let currentPos: (Int, Int)? = findNextAntenna(withFrequency: freq, afterPosition: (0, -1))
            if currentPos != nil {
                markAntinodes(currentPos: currentPos!)
            }
        }
        var sum = 0
        for antinodeRow in antinodes {
            for antinode in antinodeRow {
                if antinode {
                    sum = sum + 1
                    print("#", separator: "", terminator: "")
                } else {
                    print(".", separator: "", terminator: "")
                }
            }
            print()
        }
        print("Sum \(sum)")
    }
}
