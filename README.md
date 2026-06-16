# grokking_algorithms
Ruby implementations of algorithms from the grokking algorithms book


## Some notes on Big O

Big O is a measure of 
- the growth of how many steps are required to complete the process.
- how the number of items impacts the overall speed of the algorithm.

### Liner Search
Simple linear search runs in - O(n) - linear time

This means that the algorithm is slow and gets much slower with much larger volumes of data.

In plain English, every item in the array must be potentially visited to find the item we are looking for.

### Binary Search
Binary Search runs in O(log n) - logarithmic time.

This means that the algorithm continues to scale well with much larger volumes of data.

For example
- 1 million items in an array will require at most - 20 steps
- 20 steps - is  2 to the power of 20
- In plain English the algorithm divides the starting number by 2 for each step it takes until it reaches 1.
- We would need to multiply 2 by itself 20 times to reach a number just slightly larger than 1 million = 20 steps.

Compare this to Linear Search 
- 1 million items in the array would require - 1 million steps O(n)

### Selection Sort
Selection Sort runs in - O(n * n) - 


## Some notes on Data Structures

| Structure    | Reading | Insertion | Deletion | Better for                                                          |
|--------------|---------|-----------|----------|---------------------------------------------------------------------|
| Arrays       | O(1)    | O(n)      | O(n)     | Dynamic Reads, quickly reading a value at any position in the array |
| Linked Lists | O(n)    | O(1)      | O(1)     | Sequential Reads, processing one after another in fixed order       |
 
