# Gravity Sort Visualization Guide

## Quick Reference

| Want to... | Run this | Best for |
|------------|----------|----------|
| **See how it works** | `gravitysort_visualized` | Understanding the algorithm |
| **Watch it animate** | `gravitysort_animated` | Teaching/presentations |
| **Try everything** | `demo_all_visualizations` | Exploring all options |
| **Max performance** | `gravitysort` | Large datasets, benchmarking |
| **Verify correctness** | `test_gravitysort` | Testing after changes |

## Detailed Guide

### 1. Static Visualization (`gravitysort_visualized`)

**What it shows:**
- Three panels side-by-side
- Panel 1: Initial bead placement
- Panel 2: After gravity applied
- Panel 3: Sorted output bar chart

**When to use:**
- First time learning the algorithm
- Need clear before/after comparison
- Presenting in slides/documents
- Want to see all steps at once

**Dataset size:** 20 elements, range 1-50

**Example output:**
```
Input:  [34, 12, 45, 23, ...]
Sorted: [12, 23, 34, 45, ...]
✓ Correctly sorted!
```

**Visual features:**
- Blue beads on white background
- Grid overlay for clarity
- Each bead is a filled cell
- Bottom of matrix = bottom of container

---

### 2. Animated Visualization (`gravitysort_animated`)

**What it shows:**
- Smooth animation of beads falling
- Real-time progress indicator
- Live bar chart updates
- Easing functions for natural motion

**When to use:**
- Teaching in classroom
- Live presentations
- Understanding the "gravity" concept
- Making videos/recordings
- Demonstrating algorithm beauty

**Dataset size:** 15 elements, range 1-30

**Animation details:**
- 30 frames of smooth motion
- Ease-in-out timing function
- 50ms per frame (adjustable)
- Shows progress percentage

**Example:**
```
Animated Gravity Sort
=====================
Input data: [23, 5, 18, 12, ...]

[Animation plays - watch beads fall!]

Sorted data: [5, 12, 18, 23, ...]
✓ Correctly sorted!
```

---

### 3. Interactive Demo (`demo_all_visualizations`)

**What it shows:**
- Menu-driven interface
- 5 different modes to choose from
- Customizable parameters

**Menu options:**

```
1. Static Step-by-Step Visualization (20 elements)
   → Best for: First-time users
   → Shows: 3-panel comparison

2. Animated Falling Beads (15 elements)
   → Best for: Visual learners
   → Shows: Smooth animation

3. Performance Benchmark (2500 elements, no viz)
   → Best for: Performance testing
   → Shows: Timing comparison with MATLAB sort

4. Compare All (small dataset)
   → Best for: Understanding differences
   → Shows: All methods on same data

5. Custom Parameters
   → Best for: Experimentation
   → Input: n, r, visualization mode
```

**When to use:**
- Exploring different visualization options
- Teaching a class (interactive)
- Comparing performance
- Custom experiments

---

### 4. Optimized Sort (`gravitysort`)

**What it shows:**
- Console output only
- Timing information
- No graphics

**When to use:**
- Large datasets (n > 1000)
- Performance benchmarking
- Production use
- Testing optimization impact

**Dataset size:** 2500 elements, range 1-100,000

**Output:**
```
Elapsed time is 0.1234 seconds.
```

**Performance:**
- Memory: O(sum of values) - sparse
- Speed: 50-90% faster than naive
- Handles huge ranges efficiently

---

### 5. Test Suite (`test_gravitysort`)

**What it shows:**
- Test results for various cases
- Pass/fail indicators
- Input/output comparisons

**When to use:**
- After modifying code
- Verifying correctness
- Regression testing
- Before committing changes

**Test cases:**
- Small dataset (10 elements)
- Edge case: All same values
- Edge case: Already sorted
- Edge case: Reverse sorted
- Edge case: Single element
- Edge case: Duplicates

**Output:**
```
Test 1: Small dataset (n=10, r=20)
✓ Test 1 PASSED

Test 2: Edge cases
✓ Test 2 PASSED (all edge cases)

All tests completed!
```

---

## Visual Elements Explained

### Bead Matrix Display

```
Column →  (represents height/value position)
Row ↓     (represents which number)

Blue cell ●  = Bead (value = 1)
White cell □ = Empty space (value = 0)
```

**Example:**
```
Value 3:  □ □ □ □ ● ● ●  (3 beads on the right)
Value 1:  □ □ □ □ □ □ ●  (1 bead on the right)
Value 4:  □ □ □ ● ● ● ●  (4 beads on the right)
```

After gravity (column-wise):
```
Column sums stay same, but beads move to bottom
Result: Row sums now represent sorted values!
```

---

## Customization Tips

### Adjust Animation Speed
In `gravitysort_animated.m`, line with `pause()`:
```matlab
pause(0.05);  % Default: 50ms per frame

pause(0.1);   % Slower (good for teaching)
pause(0.02);  # Faster (good for demos)
pause(0.01);  % Very fast
```

### Change Dataset Size
At the top of each file:
```matlab
n = 20;   % Number of elements
r = 50;   % Range (1 to r)
```

### Modify Colors
In visualization functions:
```matlab
% Blue beads
colormap(flipud([1 1 1; 0.2 0.4 0.6]));

% Red beads
colormap(flipud([1 1 1; 0.8 0.2 0.2]));

% Green beads
colormap(flipud([1 1 1; 0.2 0.8 0.2]));
```

### Adjust Figure Size
```matlab
figure('Position', [x, y, width, height]);

% Examples:
figure('Position', [100, 100, 800, 600]);   % Smaller
figure('Position', [100, 100, 1600, 900]);  # Larger
figure('Position', [0, 0, 1920, 1080]);     % Full HD
```

---

## Troubleshooting

**Problem:** Visualization window too small
**Solution:** Maximize window or adjust `Position` parameter

**Problem:** Animation too fast/slow
**Solution:** Modify `pause()` value in animation loop

**Problem:** Out of memory
**Solution:** Reduce `n` or `r` parameters

**Problem:** Beads not visible
**Solution:** Reduce dataset size for better visibility

**Problem:** MATLAB version error
**Solution:** Requires R2016b or later

---

## Performance Comparison

| Mode | Dataset | Memory | Speed | Visualization |
|------|---------|--------|-------|---------------|
| Optimized | 2500 | ~20MB | Fast | None |
| Static viz | 20 | <1MB | Fast | High quality |
| Animated | 15 | <1MB | Medium | Smooth |
| Benchmark | 2500 | ~20MB | Fast | Text only |

---

## Best Practices

1. **Start with static** visualization to understand the concept
2. **Use animated** to see the gravity effect in action
3. **Try demo mode** to explore all options
4. **Run benchmarks** to see performance gains
5. **Customize** for your specific needs

## Algorithm Insight

The visualization helps you see:
- How numbers become physical beads
- How gravity sorts naturally
- Why it's O(n + sum) complexity
- Where sparse matrices save memory
- How column operations work

**Key observation:**
When beads fall, they automatically organize by height because:
- Shorter columns have fewer beads
- Taller columns have more beads
- After gravity, row sums = sorted values!

---

**Happy visualizing!** 🎨
