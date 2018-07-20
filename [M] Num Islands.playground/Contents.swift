/*
 Num Islands.swift
 200. Number of Islands
 Link: https://leetcode.com/problems/number-of-islands/
 
 Initial Thoughts:
 - Simple DFS connecting related limbs to a specified island.
 - Would be nice to pass a tag so we can visually see which islands are counted and in what order.
 - Have to iterate over the entire grid and will use a copy of the grid to store visited locations.
 
 Optimizations:
 - Ended up not passing a tag:
    - Was going to use the island count incremented but that would require converting the integer into a character.
 - Checking bounds before exploring neighbors is more efficient than a guard statement covering all the cases.
*/

class Solution {
    func numIslands(_ mutableGrid: inout [[Character]]) -> Int {
        var islandCount = 0
        
        for row in 0 ..< mutableGrid.count {
            for col in 0 ..< mutableGrid[row].count where mutableGrid[row][col] == "1" {
                islandCount += 1
                visit(&mutableGrid, row: row, col: col)
            }
        }
        
        return islandCount
    }
    
    private func visit(_ grid: inout [[Character]], row: Int, col: Int) {
        guard grid[row][col] == "1" else { return }
        grid[row][col] = "V"
        
        // Branch out to neighbors if they are within bounds.
        if row > 0                      { visit(&grid, row: row - 1, col: col) }
        if col > 0                      { visit(&grid, row: row, col: col - 1) }
        if row + 1 < grid.count         { visit(&grid, row: row + 1, col: col) }
        if col + 1 < grid[row].count    { visit(&grid, row: row, col: col + 1) }
    }
}

var input: [[Character]] = [["1","1","1"],
                            ["0","1","0"],
                            ["1","1","1"],
                            ["1","1","1"],
                            ["0","1","0"],
                            ["1","1","1"]]

print("Before:")
input.forEach {
    print($0)
}

Solution().numIslands(&input)

print("\nAfter")
input.forEach {
    print($0)
}
