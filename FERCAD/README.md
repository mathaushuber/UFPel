## Quine-McCluskey
The Quine–McCluskey algorithm (QMC), also known as the method of prime implicants, is a method used for minimization of Boolean functions that was developed by Willard V. Quine in 1952 and extended by Edward J. McCluskey in 1956.

This algorithm is functionally identical to Karnaugh mapping, but the tabular form makes it more efficient for use in computer algorithms, and it also gives a deterministic way to check that the minimal form of a Boolean function has been reached. It is sometimes referred to as the tabulation method.

The method involves two steps:

1. Finding all prime implicants of the function.

2. Use those prime implicants in a prime implicant chart to find the essential prime implicants of the function, as well as other prime implicants that are necessary to cover the function.

## Maze Router (Lee)

The Lee algorithm is one possible solution for maze routing problems based on breadth-first search. It always gives an optimal solution, if one exists, but is slow and requires considerable memory.

The method involves three steps:

1. Make an empty queue and enqueue the source cell with a distance of 0 from the source (itself), marking it as visited.
2. Loop until the queue is empty.
Dequeue the front node.
If the popped node is the destination node, then return its distance.
Otherwise, for each of four adjacent cells of the current cell, enqueue each valid cell with +1 distance and mark them as visited.
3. Return false if the destination is not reached after processing all queue nodes.
