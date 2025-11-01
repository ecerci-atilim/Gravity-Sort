% Comprehensive Demo of Gravity Sort Visualizations
% This script demonstrates all visualization options

function demo_all_visualizations()
    fprintf('========================================\n');
    fprintf('  Gravity Sort Visualization Demo\n');
    fprintf('========================================\n\n');

    % Menu
    fprintf('Select visualization mode:\n');
    fprintf('1. Static Step-by-Step Visualization (20 elements)\n');
    fprintf('2. Animated Falling Beads (15 elements)\n');
    fprintf('3. Performance Benchmark (2500 elements, no viz)\n');
    fprintf('4. Compare All (small dataset)\n');
    fprintf('5. Custom Parameters\n');
    fprintf('\nEnter choice (1-5): ');

    choice = input('');

    fprintf('\n');

    switch choice
        case 1
            fprintf('Running static visualization...\n\n');
            gravitysort_visualized();

        case 2
            fprintf('Running animated visualization...\n');
            fprintf('(Watch the beads fall!)\n\n');
            gravitysort_animated();

        case 3
            fprintf('Running performance benchmark...\n');
            benchmark_gravity_sort();

        case 4
            fprintf('Running comparison with small dataset...\n\n');
            compare_all_modes();

        case 5
            fprintf('Enter number of elements: ');
            n = input('');
            fprintf('Enter range (max value): ');
            r = input('');
            fprintf('Visualize? (1=static, 2=animated, 0=no): ');
            viz = input('');

            custom_gravity_sort(n, r, viz);

        otherwise
            fprintf('Invalid choice. Running static visualization...\n\n');
            gravitysort_visualized();
    end

    fprintf('\n========================================\n');
    fprintf('  Demo Complete!\n');
    fprintf('========================================\n');
end

function benchmark_gravity_sort()
    n = 2500;
    r = 1e5;

    fprintf('Benchmarking optimized gravity sort\n');
    fprintf('Parameters: n=%d, r=%d\n\n', n, r);

    rng default;
    data = randi(r, 1, n);

    fprintf('Starting sort...\n');
    tic;

    maxVal = max(data);
    dataLen = length(data);
    totalElements = sum(data);
    rowIdx = zeros(1, totalElements);
    colIdx = zeros(1, totalElements);

    idx = 1;
    for i = 1 : dataLen
        numCols = data(i);
        if numCols > 0
            cols = (maxVal - numCols + 1) : maxVal;
            rowIdx(idx:idx+numCols-1) = i;
            colIdx(idx:idx+numCols-1) = cols;
            idx = idx + numCols;
        end
    end

    s = sparse(rowIdx, colIdx, 1, dataLen, maxVal);
    colSums = full(sum(s, 1));
    nonZeroCols = find(colSums > 0);
    numNonZero = length(nonZeroCols);
    totalElements2 = sum(colSums(nonZeroCols));
    rowIdx2 = zeros(1, totalElements2);
    colIdx2 = zeros(1, totalElements2);

    idx = 1;
    for j = 1 : numNonZero
        i = nonZeroCols(j);
        numRows = colSums(i);
        rows = (dataLen - numRows + 1) : dataLen;
        rowIdx2(idx:idx+numRows-1) = rows;
        colIdx2(idx:idx+numRows-1) = i;
        idx = idx + numRows;
    end

    s = sparse(rowIdx2, colIdx2, 1, dataLen, maxVal);
    sorted = full(sum(s, 2))';

    elapsed = toc;

    fprintf('Gravity sort completed in %.4f seconds\n', elapsed);
    fprintf('Verification: ');
    if isequal(sorted, sort(data))
        fprintf('✓ Correctly sorted!\n');
    else
        fprintf('✗ Sort failed!\n');
    end

    % Compare with MATLAB's built-in sort
    fprintf('\nComparing with MATLAB sort...\n');
    tic;
    matlab_sorted = sort(data);
    matlab_time = toc;
    fprintf('MATLAB sort completed in %.4f seconds\n', matlab_time);

    fprintf('\nMemory efficiency:\n');
    fprintf('  Non-zero elements: %d\n', totalElements);
    fprintf('  Max possible (dense): %d × %d = %d\n', dataLen, maxVal, dataLen * maxVal);
    fprintf('  Sparsity: %.2f%%\n', 100 * (1 - totalElements / (dataLen * maxVal)));
end

function compare_all_modes()
    n = 12;
    r = 25;

    fprintf('Comparing all visualization modes\n');
    fprintf('Dataset: n=%d, r=%d\n\n', n, r);

    rng(42);  % Fixed seed
    data = randi(r, 1, n);

    fprintf('Input: ');
    disp(data);

    fprintf('\n1. Static visualization opening...\n');
    pause(1);
    sorted1 = run_static_viz(data);

    fprintf('\n2. Press any key for animated visualization...\n');
    pause;
    sorted2 = run_animated_viz(data);

    fprintf('\nResults:\n');
    fprintf('  Static viz result:   ');
    disp(sorted1);
    fprintf('  Animated viz result: ');
    disp(sorted2);
    fprintf('  MATLAB sort result:  ');
    disp(sort(data));

    if isequal(sorted1, sorted2) && isequal(sorted1, sort(data))
        fprintf('\n✓ All methods produced identical results!\n');
    else
        fprintf('\n✗ Methods produced different results!\n');
    end
end

function sorted = run_static_viz(data)
    maxVal = max(data);
    dataLen = length(data);
    totalElements = sum(data);
    rowIdx = zeros(1, totalElements);
    colIdx = zeros(1, totalElements);

    idx = 1;
    for i = 1 : dataLen
        numCols = data(i);
        if numCols > 0
            cols = (maxVal - numCols + 1) : maxVal;
            rowIdx(idx:idx+numCols-1) = i;
            colIdx(idx:idx+numCols-1) = cols;
            idx = idx + numCols;
        end
    end

    s = sparse(rowIdx, colIdx, 1, dataLen, maxVal);

    figure('Name', 'Static Comparison', 'Position', [50, 300, 1000, 400]);
    subplot(1, 2, 1);
    imagesc(full(s));
    colormap(flipud([1 1 1; 0.2 0.4 0.6]));
    title('Before Gravity');
    set(gca, 'YDir', 'normal');

    colSums = full(sum(s, 1));
    nonZeroCols = find(colSums > 0);
    totalElements2 = sum(colSums(nonZeroCols));
    rowIdx2 = zeros(1, totalElements2);
    colIdx2 = zeros(1, totalElements2);

    idx = 1;
    for j = 1:length(nonZeroCols)
        i = nonZeroCols(j);
        numRows = colSums(i);
        rows = (dataLen - numRows + 1) : dataLen;
        rowIdx2(idx:idx+numRows-1) = rows;
        colIdx2(idx:idx+numRows-1) = i;
        idx = idx + numRows;
    end

    s = sparse(rowIdx2, colIdx2, 1, dataLen, maxVal);
    sorted = full(sum(s, 2))';

    subplot(1, 2, 2);
    imagesc(full(s));
    colormap(flipud([1 1 1; 0.2 0.4 0.6]));
    title('After Gravity');
    set(gca, 'YDir', 'normal');
    sgtitle('Static Visualization');
end

function sorted = run_animated_viz(data)
    % Simplified animation for comparison
    sorted = gravity_sort_simple_anim(data);
end

function sorted = gravity_sort_simple_anim(data)
    maxVal = max(data);
    dataLen = length(data);
    totalElements = sum(data);
    rowIdx = zeros(1, totalElements);
    colIdx = zeros(1, totalElements);

    idx = 1;
    for i = 1 : dataLen
        numCols = data(i);
        if numCols > 0
            cols = (maxVal - numCols + 1) : maxVal;
            rowIdx(idx:idx+numCols-1) = i;
            colIdx(idx:idx+numCols-1) = cols;
            idx = idx + numCols;
        end
    end

    s_initial = sparse(rowIdx, colIdx, 1, dataLen, maxVal);

    colSums = full(sum(s_initial, 1));
    nonZeroCols = find(colSums > 0);
    totalElements2 = sum(colSums(nonZeroCols));
    rowIdx2 = zeros(1, totalElements2);
    colIdx2 = zeros(1, totalElements2);

    idx = 1;
    for j = 1:length(nonZeroCols)
        i = nonZeroCols(j);
        numRows = colSums(i);
        rows = (dataLen - numRows + 1) : dataLen;
        rowIdx2(idx:idx+numRows-1) = rows;
        colIdx2(idx:idx+numRows-1) = i;
        idx = idx + numRows;
    end

    s_final = sparse(rowIdx2, colIdx2, 1, dataLen, maxVal);

    % Simple animation
    figure('Name', 'Animated Comparison', 'Position', [100, 300, 600, 400]);
    for t = 0:0.1:1
        clf;
        imagesc(full(s_initial) * (1-t) + full(s_final) * t);
        colormap(flipud([1 1 1; 0.2 0.4 0.6]));
        title(sprintf('Animation Progress: %.0f%%', t*100));
        set(gca, 'YDir', 'normal');
        drawnow;
        pause(0.05);
    end

    sorted = full(sum(s_final, 2))';
end

function custom_gravity_sort(n, r, viz_mode)
    rng default;
    data = randi(r, 1, n);

    fprintf('Custom parameters: n=%d, r=%d\n', n, r);
    fprintf('Input data: ');
    disp(data);

    tic;

    if viz_mode == 1 && n <= 50
        sorted = run_static_viz(data);
    elseif viz_mode == 2 && n <= 30
        sorted = run_animated_viz(data);
    else
        sorted = gravity_sort_no_viz(data);
    end

    elapsed = toc;

    fprintf('\nSorted data: ');
    disp(sorted);
    fprintf('Time: %.4f seconds\n', elapsed);
    fprintf('Verification: ');
    if isequal(sorted, sort(data))
        fprintf('✓ Correct!\n');
    else
        fprintf('✗ Failed!\n');
    end
end

function sorted = gravity_sort_no_viz(data)
    maxVal = max(data);
    dataLen = length(data);
    totalElements = sum(data);
    rowIdx = zeros(1, totalElements);
    colIdx = zeros(1, totalElements);

    idx = 1;
    for i = 1 : dataLen
        numCols = data(i);
        if numCols > 0
            cols = (maxVal - numCols + 1) : maxVal;
            rowIdx(idx:idx+numCols-1) = i;
            colIdx(idx:idx+numCols-1) = cols;
            idx = idx + numCols;
        end
    end

    s = sparse(rowIdx, colIdx, 1, dataLen, maxVal);
    colSums = full(sum(s, 1));
    nonZeroCols = find(colSums > 0);
    totalElements2 = sum(colSums(nonZeroCols));
    rowIdx2 = zeros(1, totalElements2);
    colIdx2 = zeros(1, totalElements2);

    idx = 1;
    for j = 1:length(nonZeroCols)
        i = nonZeroCols(j);
        numRows = colSums(i);
        rows = (dataLen - numRows + 1) : dataLen;
        rowIdx2(idx:idx+numRows-1) = rows;
        colIdx2(idx:idx+numRows-1) = i;
        idx = idx + numRows;
    end

    s = sparse(rowIdx2, colIdx2, 1, dataLen, maxVal);
    sorted = full(sum(s, 2))';
end
