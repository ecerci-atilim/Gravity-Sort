%% GRAVITY SORT - QUICK START GUIDE
% Run this script to get started with Gravity Sort visualizations!
%
% This script will walk you through the main features.
% Just run this file in MATLAB and follow along.

%% Introduction
clc;
fprintf('╔════════════════════════════════════════════════════════╗\n');
fprintf('║     GRAVITY SORT - Quick Start Guide                  ║\n');
fprintf('╚════════════════════════════════════════════════════════╝\n\n');

fprintf('Welcome to Gravity Sort!\n\n');
fprintf('This algorithm sorts numbers by simulating gravity on beads.\n');
fprintf('Think of it like an abacus where beads fall to the bottom!\n\n');

fprintf('Press any key to see a small example...\n');
pause;

%% Small Example
clc;
fprintf('═══════════════════════════════════════════════════════\n');
fprintf('EXAMPLE: How Gravity Sort Works\n');
fprintf('═══════════════════════════════════════════════════════\n\n');

example_data = [5, 2, 8, 3, 6];
fprintf('Input array: ');
disp(example_data);

fprintf('\nStep 1: Represent each number as beads\n');
fprintf('  5 → ●●●●● (5 beads)\n');
fprintf('  2 → ●●     (2 beads)\n');
fprintf('  8 → ●●●●●●●● (8 beads)\n');
fprintf('  3 → ●●●    (3 beads)\n');
fprintf('  6 → ●●●●●● (6 beads)\n\n');

fprintf('Step 2: Apply gravity (beads fall down in each column)\n');
fprintf('Step 3: Count beads in each row → Sorted!\n\n');

fprintf('Output array: ');
disp(sort(example_data));

fprintf('\nThat''s the basic idea! Now let''s see it visually.\n\n');
fprintf('Press any key to continue...\n');
pause;

%% Visualization Options
clc;
fprintf('═══════════════════════════════════════════════════════\n');
fprintf('VISUALIZATION OPTIONS\n');
fprintf('═══════════════════════════════════════════════════════\n\n');

fprintf('We have several visualization modes:\n\n');

fprintf('1. STATIC VISUALIZATION\n');
fprintf('   → Shows before/after in 3 panels\n');
fprintf('   → Best for: Understanding the algorithm\n');
fprintf('   → Run: gravitysort_visualized\n\n');

fprintf('2. ANIMATED VISUALIZATION\n');
fprintf('   → Watch beads fall in real-time!\n');
fprintf('   → Best for: Teaching & presentations\n');
fprintf('   → Run: gravitysort_animated\n\n');

fprintf('3. INTERACTIVE DEMO\n');
fprintf('   → Menu with multiple options\n');
fprintf('   → Best for: Exploring all features\n');
fprintf('   → Run: demo_all_visualizations\n\n');

fprintf('4. PERFORMANCE MODE\n');
fprintf('   → Optimized for speed (no graphics)\n');
fprintf('   → Best for: Large datasets\n');
fprintf('   → Run: gravitysort\n\n');

fprintf('Let''s try the STATIC visualization first!\n');
fprintf('Press any key to launch...\n');
pause;

%% Run Static Visualization
try
    clc;
    fprintf('Launching static visualization...\n\n');
    gravitysort_visualized();

    fprintf('\n\nGreat! You should see a figure with 3 panels:\n');
    fprintf('  • Left: Initial bead positions\n');
    fprintf('  • Middle: After gravity\n');
    fprintf('  • Right: Sorted values as bar chart\n\n');

    fprintf('Press any key to try the ANIMATED version...\n');
    pause;

catch ME
    fprintf('Note: Could not run visualization.\n');
    fprintf('Make sure all .m files are in your MATLAB path.\n\n');
    fprintf('Error: %s\n\n', ME.message);
    fprintf('Press any key to continue...\n');
    pause;
end

%% Run Animated Visualization
try
    clc;
    fprintf('Launching animated visualization...\n');
    fprintf('Watch the beads fall!\n\n');

    gravitysort_animated();

    fprintf('\n\nAwesome! You just watched gravity in action!\n');
    fprintf('The beads smoothly fall to their sorted positions.\n\n');

catch ME
    fprintf('Note: Could not run animation.\n');
    fprintf('Error: %s\n\n', ME.message);
end

fprintf('Press any key to continue...\n');
pause;

%% Performance Info
clc;
fprintf('═══════════════════════════════════════════════════════\n');
fprintf('PERFORMANCE OPTIMIZATIONS\n');
fprintf('═══════════════════════════════════════════════════════\n\n');

fprintf('This implementation is highly optimized:\n\n');

fprintf('✓ Sparse matrices (99%% memory reduction)\n');
fprintf('✓ Pre-allocated arrays (no dynamic resizing)\n');
fprintf('✓ Vectorized operations (faster computation)\n');
fprintf('✓ Skip empty columns (fewer iterations)\n\n');

fprintf('For n=2500, range=100,000:\n');
fprintf('  Memory: ~2GB → ~20MB (99%% reduction)\n');
fprintf('  Speed:  50-90%% faster than naive version\n\n');

fprintf('See OPTIMIZATIONS.md for detailed analysis.\n\n');

fprintf('Press any key to continue...\n');
pause;

%% Next Steps
clc;
fprintf('═══════════════════════════════════════════════════════\n');
fprintf('NEXT STEPS\n');
fprintf('═══════════════════════════════════════════════════════\n\n');

fprintf('Ready to explore more? Try these:\n\n');

fprintf('📊 Interactive Demo:\n');
fprintf('   >> demo_all_visualizations\n\n');

fprintf('🧪 Run Tests:\n');
fprintf('   >> test_gravitysort\n\n');

fprintf('⚡ Performance Benchmark:\n');
fprintf('   >> gravitysort\n\n');

fprintf('📖 Documentation:\n');
fprintf('   • README.md - Overview and usage\n');
fprintf('   • OPTIMIZATIONS.md - Technical details\n');
fprintf('   • VISUALIZATION_GUIDE.md - Visual options\n\n');

fprintf('🎨 Customize:\n');
fprintf('   • Edit n and r parameters in any file\n');
fprintf('   • Adjust colors: modify colormap() calls\n');
fprintf('   • Change speed: modify pause() values\n\n');

%% Example Code
fprintf('═══════════════════════════════════════════════════════\n');
fprintf('EXAMPLE: Custom Visualization\n');
fprintf('═══════════════════════════════════════════════════════\n\n');

fprintf('Want to try your own data? Here''s how:\n\n');
fprintf('1. Create your data:\n');
fprintf('   >> my_data = [10, 5, 8, 3, 12];\n\n');

fprintf('2. Edit gravitysort_visualized.m:\n');
fprintf('   → Change line with "data = randi(...)"\n');
fprintf('   → Replace with "data = my_data;"\n\n');

fprintf('3. Run the visualization:\n');
fprintf('   >> gravitysort_visualized\n\n');

fprintf('Or use demo_all_visualizations with option 5 (Custom)\n');
fprintf('to specify your own parameters!\n\n');

%% Final Message
fprintf('═══════════════════════════════════════════════════════\n');
fprintf('YOU''RE ALL SET!\n');
fprintf('═══════════════════════════════════════════════════════\n\n');

fprintf('Quick reference:\n');
fprintf('  gravitysort_visualized     → Static visualization\n');
fprintf('  gravitysort_animated       → Animated beads\n');
fprintf('  demo_all_visualizations    → Interactive menu\n');
fprintf('  gravitysort                → Performance mode\n');
fprintf('  test_gravitysort           → Run tests\n\n');

fprintf('📚 Read the docs: README.md, VISUALIZATION_GUIDE.md\n');
fprintf('🐛 Found a bug? Check test_gravitysort.m\n');
fprintf('🎨 Want to customize? All files are well-commented!\n\n');

fprintf('Enjoy exploring Gravity Sort!\n');
fprintf('Watch those beads fall! 🎯\n\n');

fprintf('═══════════════════════════════════════════════════════\n');
