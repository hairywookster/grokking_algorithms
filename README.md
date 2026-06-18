# grokking_algorithms
Ruby implementations of algorithms from the grokking algorithms book


## Some notes on Big O

Big O is a measure of the complexity/efficiency of an algorithm/data structure
- the growth of how many steps are required to complete the process.
- how the number of items impacts the overall speed of the algorithm.

Worth noting that in Big O notation any constant is ignored in the notation.


### Common Big O's

| Notation     | English Description          | Alogirthms                                                  |
|--------------|------------------------------|-------------------------------------------------------------|
| O(1)         | constant time                | Array Lookup                                                |
| O(n)         | linear time                  | Linear Search                                               |
| O(log n)     | logarithmic time             | Binary Search                                               |
| O(n * n)     | quadratic time               | Bubble Sort / Selection Sort                                |
| O(n log n)   | loglinear time (superlinear) | Heap Sort / Merge Sort / Quick Sort                         |
| O(n * n * n) | cubic time                   | Naive matrix multiplication                                 |
| O(n^c)       | polynomial                   | Bubble Sort / Selection Sort / Insertion Sort / Bucket Sort |
| O(c^n)       | exponential                  | Tower of Hanoi                                              |
| O(n!)        | factorial time               | Brute force Traveling Salesman                              |

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
Selection Sort runs in - O(n * n) - quadratic time

This means that as the data size grows, the number of operations required to process the data grows ata  squared rate.
So if you double your data size, it will take quadruple the amount of time to process.

### Quicksort
Quicksort runs in - O(n log n) - loglinear time

This means it is much faster than selection sort and maintains its speed as much more data is added.

### Hash Table / Hash Map (data structure)
Hashmaps runs in - O(1) - constant time

This means it's as fast as an array for reading, and as fast as a linked list for insertion and deletion under avg case.
In worst case they can be as slow as Arrays and Linked Lists.

Important factors of Hash Tables

#### low load factor
Load factor is how many of the Hash slots contain a value (similar to a row of boxes with some containing
something and others containing nothing). 
- if we have 5 slots and 10 items our load factor would be 2. 
- If we have 10 slots and 5 items our load factor would be 0.5
- consider resizing when load factor gets above 0.7

#### good hash function
The Hash function distributes items evenly in the Hash table's underlying storage, whilst doing its best to avoid conflicts. 
It converts the things being stored into a consistent value (think identifier) to determine where it will be stored.

For example, if it were storing names, it might have an array with 26 spaces, one for each letter of the alphabet. 
The hashing function would distribute the names into these spaces based on the first character of the name.
Each array index would either contain nothing, a name, or a linked list of other names that start with the same letter.


## Some notes on Data Structures

| Structure      | Reading     | Insertion   | Deletion    | Better for                                                          |
|----------------|-------------|-------------|-------------|---------------------------------------------------------------------|
| Arrays         | O(1)        | O(n)        | O(n)        | Dynamic Reads, quickly reading a value at any position in the array |
| Linked Lists   | O(n)        | O(1)        | O(1)        | Sequential Reads, processing one after another in fixed order       |
| Hash Table/Map | O(1) / O(n) | O(1) / O(n) | O(1) / O(n) | Lookups/Caching/Mapping one thing to another with efficient lookup. |

(Note the Big O's are given for Avg Case/Worst Case where two are presented) 
