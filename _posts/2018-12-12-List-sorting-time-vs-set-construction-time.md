---
layout: post
title: A little experiment to know performance among sorting versus set construction
description: Sometimes it is also fun to write a few lines of code to see the performance instead of reading documents to understand the time complexity. Below code is a little experiment where I am comparing the list sort method in python and set construction from a list on 10 million random numbers.
author: author1
canonical_url: https://gist.github.com/ajayramezh/5e985bd0ef1ed2a8da3339de13deb99e
comments: true
cover: false
---

In below experiment I used two code blocks in python to test, one is `list.sort()` and `set(list)`. Below code is capturing all the time it took using python `time` library. Finally, I have plotted some graphs to write final notes about this experiment.  

```python
import time
import random
import matplotlib.pyplot as plt
import statistics
import numpy as np
```

### Experiment setup
I am trying to create a random integer list of size 10 million, conducting 10 test cases. Also 5 seconds sleep time on every experiment


```python
MIN, MAX = 0, 1000000000
N = 10000000
TEST = 10
SLEEP_TIME = 5
```


```python
change = False
stats = []
while True:
    e = []
    lst = [random.randint(MIN, MAX) for _ in range(N)]
    for i in range(1, TEST):
        """
            change --> True means list sorting experiment is going on
                       else list to set experiment is going on
        """
        t = time.process_time()
        if not change:
            lst.sort()
        else:
            set_from_lst = set(lst)
        e.append(time.process_time() - t)
        time.sleep(SLEET_TIME)
    stats.append(e)
    if change:
        break
    change = True
```

### Anaysis

**Bar plot on Both experiments**


```python
height = [statistics.median(stats[0]), statistics.median(stats[1])]
bars = ('Sorting a list', 'Lst to set')
y_pos = np.arange(len(bars))
 
# Create bars and choose color
plt.bar(y_pos, height, color = (0.5,0.1,0.5,0.6))
 
# Add title and axis names
plt.title('Sorting list VS Set construction from List')
plt.xlabel('Experiments')
plt.ylabel('Time in seconds')
 
# Limits for the Y axis
plt.ylim(0,max(max(e), max(s)))
 
# Create names
plt.xticks(y_pos, bars)
 
# Show graphic
plt.show()
```


![png](/assets/output_8_0.png)


**Time taken across all 10 experiments**


```python
plt.plot(stats[0])
plt.plot(stats[1])
plt.legend(['sorting a list', 'lst to set'])
plt.xlabel("Number of experiments")
plt.ylabel("Time in seconds")
plt.ylim(0,10)
plt.title("Time taken to complete for 10 experiments")
plt.show()
```


![png](/assets/output_10_0.png)


- How many seconds less it takes to sort an array compared to constructing a set from list ?
- Which one is faster among set construction from list or sorting a list ?


```python
"Sorting a list is {} seconds faster".format(statistics.median(stats[1]) - statistics.median(stats[0]))
```

'Sorting a list is 1.0382620000000031 seconds faster '


# Notes
- Sorting a list always takes less time compared to set construction from the list.
- Not much but few seconds difference is there. So we can safely assume approximately both will perform same
- Searching in a sorted list can happen in `O(log2(n))` time. 
- Searching in a set will be `O(1)` time.
- This experiment tested in python, but it most likely it will be true for any other languages. 

Let me know, what do you think by commenting on the post.