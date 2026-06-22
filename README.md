# grokking_algorithms
Ruby implementations of algorithms from the grokking algorithms book


## Some notes on Big O

Big O is a measure of the complexity/efficiency of an algorithm/data structure
- the growth of how many steps are required to complete the process.
- how the number of items impacts the overall speed of the algorithm.

Worth noting that in Big O notation any constant is ignored in the notation.


## Common Big O's

| Notation     | English Description          | Alogirthms                                                  |
|--------------|------------------------------|-------------------------------------------------------------|
| O(1)         | constant time                | Array Lookup                                                |
| O(n)         | linear time                  | Linear Search                                               |
| O(log n)     | logarithmic time             | Binary Search                                               |
| O(n * n)     | quadratic time               | Bubble Sort / Selection Sort                                |
| O(n log n)   | loglinear time (superlinear) | Heap Sort / Merge Sort / Quick Sort                         |
| O(V * E)     | polynomial time              | Breadth First Search                                        |
| O(V + E)     | psuedo-polynomial time       | Depth First Search                                          |
| O(n * n * n) | cubic time                   | Naive matrix multiplication                                 |
| O(n^c)       | polynomial time              | Bubble Sort / Selection Sort / Insertion Sort / Bucket Sort |
| O(c^n)       | exponential time             | Tower of Hanoi                                              |
| O(n!)        | factorial time               | Brute force Traveling Salesman                              |

## Liner Search
Simple linear search runs in - O(n) - linear time

This means that the algorithm is slow and gets much slower with much larger volumes of data.

In plain English, every item in the array must be potentially visited to find the item we are looking for.

## Binary Search
Binary Search runs in O(log n) - logarithmic time.

This means that the algorithm continues to scale well with much larger volumes of data.

For example
- 1 million items in an array will require at most - 20 steps
- 20 steps - is  2 to the power of 20
- In plain English the algorithm divides the starting number by 2 for each step it takes until it reaches 1.
- We would need to multiply 2 by itself 20 times to reach a number just slightly larger than 1 million = 20 steps.

Compare this to Linear Search 
- 1 million items in the array would require - 1 million steps O(n)

## Selection Sort
Selection Sort runs in - O(n * n) - quadratic time

This means that as the data size grows, the number of operations required to process the data grows ata  squared rate.
So if you double your data size, it will take quadruple the amount of time to process.

## Quicksort
Quicksort runs in - O(n log n) - loglinear time

This means it is much faster than selection sort and maintains its speed as much more data is added.

## Hash Table / Hash Map (data structure)
Hashmaps operate in - O(1) - constant time

This means it's as fast as an array for reading, and as fast as a linked list for insertion and deletion under avg case.
In worst case they can be as slow as Arrays and Linked Lists.

Important factors of Hash Tables

### low load factor
Load factor is how many of the Hash slots contain a value (similar to a row of boxes with some containing
something and others containing nothing). 
- if we have 5 slots and 10 items our load factor would be 2. 
- If we have 10 slots and 5 items our load factor would be 0.5
- consider resizing when load factor gets above 0.7

### good hash function
The Hash function distributes items evenly in the Hash table's underlying storage, whilst doing its best to avoid conflicts. 
It converts the things being stored into a consistent value (think identifier) to determine where it will be stored.

For example, if it were storing names, it might have an array with 26 spaces, one for each letter of the alphabet. 
The hashing function would distribute the names into these spaces based on the first character of the name.
Each array index would either contain nothing, a name, or a linked list of other names that start with the same letter.

## Queues (data structure)
A queue models a FIFO, First In First out approach and work just like standing in a real queue. 

Whatever is added first to the queue is the first in line to be processed. Items at the end of the queue are last to be processed.

Common terms are, enqueue and dequeue, or in ruby land unshift=enqueue and shift=dequeue

## Stacks (data structure)
A stack models a LIFO, Last in Last Out approach and works just like stacking a pile of plates.

Whatever is last added to be top of the stack is the next in line to be processed.

Common terms are, push and pop

## Graphs (data structure)
Graphs model the connection between things. Graphs consist of Nodes and Edges (think: connectors).

- can be directed - the edge is travelled in a specific direction. A node can be connected to both in-neighbours and out-neighbours.
- can be undirected - the edge is travelled in either direction. A node is connected to a neighbour.
- can acyclic or cyclic

The simplest way to model a graph is to use a Hash Table, for example

```ruby
graph = {}
graph['pete'] = ['dave', 'jane', 'satish']
graph['dave'] = ['joe','jane']
#...etc
```

## Breadth First Search (algorithm)
Breadth First Search runs in O(V * E), ( This is vertices * edges   or   nodes * connections )

Breadth First Searches are useful to solve problems like 
- shortest path between two nodes in an unweighted graph.
- is there a path between two nodes in a graph.
- what is the smallest/shortest x

BFS shortest path will not be the most efficient path if weights/costs/time is involved.

### Determining the path taken
Additionally, it is useful to store the path travelled through a PARENTS hash table.
As each node is processed, store a reference for each of the neighbouring nodes to the current node as their parent

```ruby
# before processing the nodes
parents = {}
parents[ start_node ] = nil  # start node has no parent

# later within the code that processes each node
parents[ neighbour_node_1 ] = parent_node
parents[ neighbour_node_2 ] = parent_node
...
#...etc
```

The path can be reconstructed by looking at the PARENTS hash table starting from the goal node and finding its parent, 
then the parent of that node, and so on, until you reach the start node which will have no parent.

## Trees (data structure)
Trees are a type of graph. More precisely they are a connected acyclic graph.

In most cases when we are talking about a tree we mean a tree with a root node, intermediate nodes and leaf nodes.
The root node is the top most node and contains pointer/reference to child nodes. Leaf nodes are nodes that do not have any child nodes.
The line that connects each node is called an Edge.

- Trees do not have cycles they are by nature acyclic.
- binary trees have 0/1/2 children per node  
- non-binary trees have 0/n children per node

The simplest way to model a non-binary tree is again to use a Hash Table (see graph example) or a Node class. 

The simplest way to model a binary tree is to use a Hash Table or a Node class. 

```ruby
# Assume Node has been defined and contains a left/right accessor
jane_node = Node.new(left: nil, right: nil)
bob_node = Node.new(left: nil, right: nil)
dave_node = Node.new(left: nil, right: bob_node)
root_node = Node.new(left: dave_node, right: jane_node)
#...etc
```

### Depth First Search (algorithm)
Depth First Search runs in O(V * E), ( This is vertices * edges   or   nodes * connections )

Depth First Searches are useful to solve problems like
- most efficient path between two nodes in a weighted graph. 
- By weighted we mean each edge/connection has a weight/cost/time associated with it.

DFS cannot compute the shortest number of nodes visited path, it can only determine the most efficient.

## Binary Search Trees (BST) (data structure)
Binary search trees are a specialised form of a tree where each node has at most 2 children. 
One child (left) will be less than the current node and the other (right) will be greater than the current node, making it ideal for maintaining sorted data.

Shorter depth trees are faster than longer depth trees, they require less steps to find a specific node.

BST's also perform better when they are balanced. Balanced means the depth of the tree is nearly identical on both sides. 
One way to ensure this is through rotations, whereby a new root node is chosen to better split the nodes between left and right branches.

### AVL trees (data structure)
An AVL tree is a type of balanced tree that automatically manage their balancing as items are added.

AVLs guarantee O(log n) because their height is alwasy guaranteed to be O(log n) through its self balancing process.

The AVL tree stores an extra height or balance factor at each node, which allows it to determine when and where to rotate.
The balance factor can be
- 0 the tree is balanced.
- -1 or 1 the tree is not balanced but this is okay as the difference is one only.
- -2 or 2 the tree is not balanced so it needs to be rebalanced.
The balance factor/height is set from each node that is inserted upwards. If a parent is set to -2 or 2 it needs to be rebalanced.
The child of the node becomes the parent and the parent becomes the child on the appropriate side.

## Splay Trees (data structure)
Splay trees operate similarly to an AVL tree but do not guarantee balance. 

Whenever you search for a node, it makes that node the current root. This can be useful for lookup processes whereby 
the things being most frequently being looked up bubble towards the top of the tree and are thus faster to locate.

Search time is guaranteed to be O(log n) per search.

## B trees (data structure)
B trees are a generalized form of Binary trees, most frequently used in databases.
- can have many children
- can have many keys (values per node)
- left children are less than the node's keys/values
- right children are greater than.
- optimized for physical access time (by physical we mean reduced seek mechanical disk head)
- you start processing at lower left of this type of tree and work left-to-right, snaking through the nodes.


## Dijkstra's Shortest Path (algorithm)
An algorithm to define the most efficient cost/time/distance from between 2 nodes in a weighted graph.

This is most often used in problems that require calculating the shortest path (in terms of time/distance/cost).
Or in problems that relate to trading items (i.e. making a series of trades to get to a final goal product).

It only works for weighted graphs where the weights are >= 0 (i.e. positive).

You need to use Bellman-Ford for weighted graphs that include negative weights.


## Additional Algorithms/Data Structures
We will review these in more detail later.

- Heaps (data structure)
- Priority Queues (data structure)
- Priority Heaps (data structure)
- Linear Regression (algorithm) (plotting points to make predictions)
- Inverted Indexes (data structure) (search engines - think what word appears on what pages)
- Fourier Transform (algorithm) (separates ingredients in a smoothie, or frequencies in a song)
- Parallel Algorithms (separates big problems into smaller problems to run on different machines in parallel)
- Map / Reduce (parallel algorithm)
- Bloom Filters (probabilistic data structure) (Much smaller than a hash, answers may be wrong)
- HyperLogLog (probabilistic algorithm) (approximation of unique elements in a set)(products viewed by users etc)
- Diffe-Hellman key exchange (algorithm) (create a shared secret without transmission for TLS)
- Locality sensitive hashing (algorithm) (generate a hash that's similar to similar words hashes - opposite of normal hash function) (simhash - duplicates/copyright scanning)
- Min Heaps (data structure) (min value is always at the root node)
- Max Heaps (data structure) (max value is always at the root node)
- Linear programming (simplex algorithm) (maximize something within some linear constraints) (maximize profit from resources and items you can create which use resources)
- 

## Some notes on Data Structures

| Structure           | Reading     | Insertion   | Deletion    | Better for                                                                                |
|---------------------|-------------|-------------|-------------|-------------------------------------------------------------------------------------------|
| Arrays              | O(1)        | O(n)        | O(n)        | Dynamic Reads, quickly reading a value at any position in the array                       |
| Stacks              | O(n)        | O(1)        | O(1)        | When last in first out is required                                                        |
| Queues              | O(n)        | O(1)        | O(1)        | When first in first out is required                                                       |
| Linked Lists        | O(n)        | O(1)        | O(1)        | Sequential Reads, processing one after another in fixed order                             |
| Doubly Linked Lists | O(n)        | O(1)        | O(1)        | Sequential Reads, processing one after another in fixed order but any direction           |
| Hash Table/Map      | O(1) / O(n) | O(1) / O(n) | O(1) / O(n) | Lookups/Caching/Mapping one thing to another with efficient lookup.                       |
| Trees               | O(log n)    | O(log n)    | O(log n)    | When arrays and Linked lists are too slow, the data tends to favor being stored in a tree |
| Priority Queues     |             |             |             |                                                                                           |
| Priority Heaps      |             |             |             |                                                                                           |

(Note the Big O's are given for Avg Case/Worst Case where two are presented) 

See also for more complete list
[https://www.bigocheatsheet.com/](https://www.bigocheatsheet.com/)