/*
 130. Surrounded Region
 Link: https://leetcode.com/problems/surrounded-regions/
 
 Description:
 Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.
 A region is captured by flipping all 'O's into 'X's in that surrounded region.
 
 Initial Thoughts:
 - Definitely a recursive DFS / BFS problem.
 - Inside recursive method, definitely going to have guard for inside bounds.
 - Perhaps iterate from 1 inwards and search neighbors to see if they are connected to the edge.
 - Definitely want to use some sort of way to remember visited elements.
 
 After Thoughts:
 - Better solution was to iterate from the edges inwards, connecting and converting the valid neighbors to an edge element.
 - Using the same board to set the edge elements is best way to store visited elements.
 - Elements that are connected will be converted and setting their new state before traversing prevents us from creating an infinite cycle.
 
 Optimizations:
 - I initially really wanted to figure out a way to only use checks to two neighbors
*/

class Solution {
    func solve(_ board: inout [[Character]]) {
        guard board.count > 2 else { return }
        // Connect the left and right edges.
        for row in 0 ..< board.count {
            connect(row: row, col: 0, board: &board)
            connect(row: row, col: board[0].count - 1, board: &board)
        }
        
        // Connect the top and bottom edges.
        for col in 1 ..< board[0].count - 1 {
            connect(row: 0, col: col, board: &board)
            connect(row: board.count - 1, col: col, board: &board)
        }
        
        // Iterate through and replace those that need to be replaced.
        for r in 0 ..< board.count {
            for c in 0 ..< board[r].count {
                switch board[r][c] {
                case "E": board[r][c] = "O"
                case "O": board[r][c] = "X"
                default: continue
                }
            }
        }
    }
    
    private func connect(row: Int, col: Int, board: inout [[Character]]) {
        // Make sure we are within bounds.
        guard row >= 0, col >= 0, row < board.count, col < board[0].count else {
            return
        }
        
        // Make sure the position is an O.
        guard board[row][col] == "O" else { return }
        
        // Connect to the edge and then branch to neighbors.
        board[row][col] = "E"
        connect(row: row + 1, col: col, board: &board)
        connect(row: row - 1, col: col, board: &board)
        connect(row: row, col: col + 1, board: &board)
        connect(row: row, col: col - 1, board: &board)
    }
}

var input: [[Character]] = [["O","X","X","O"],
                            ["X","O","O","X"],
                            ["X","X","O","X"],
                            ["X","O","X","X"],
                            ["O","O","X","X"],
                            ["X","X","X","X"]]
print("Before:")
input.forEach {
    print($0)
}

Solution().solve(&input)

print("\nAfter:")
input.forEach {
    print($0)
}


