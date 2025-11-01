% Gravity Sort with Visualization
% This version shows the sorting process visually

function gravitysort_visualized()
    % Parameters
    n       = 20;                               % Number of integers (reduced for better visualization)
    r       = 50;                               % Range of integers (from 1 to r)

    rng default                                 % Default random number generator

    data    = randi(r, 1, n);                   % Random data generation

    fprintf('Gravity Sort Visualization\n');
    fprintf('==========================\n');
    fprintf('Input data: ');
    disp(data);
    fprintf('\n');

    % Start timing
    tic;

    % Run gravity sort with visualization
    sorted = gravity_sort_with_viz(data);

    % End timing
    elapsed = toc;

    fprintf('\nSorted data: ');
    disp(sorted);
    fprintf('Time elapsed: %.4f seconds\n', elapsed);
    fprintf('\nVerification: ');
    if isequal(sorted, sort(data))
        fprintf('✓ Correctly sorted!\n');
    else
        fprintf('✗ Sort failed!\n');
    end
end

function sorted = gravity_sort_with_viz(data)
    maxVal = max(data);
    dataLen = length(data);

    % Build sparse matrix for initial bead placement
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

    % Create figure for visualization
    figure('Name', 'Gravity Sort Visualization', 'Position', [100, 100, 1200, 600]);

    % Subplot 1: Initial bead configuration
    subplot(1, 3, 1);
    visualize_beads(full(s), 'Initial Bead Configuration');
    title('Step 1: Initial Beads', 'FontSize', 14, 'FontWeight', 'bold');

    % Apply gravity
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

    s_gravity = sparse(rowIdx2, colIdx2, 1, dataLen, maxVal);

    % Subplot 2: After gravity applied
    subplot(1, 3, 2);
    visualize_beads(full(s_gravity), 'After Gravity Applied');
    title('Step 2: Gravity Applied', 'FontSize', 14, 'FontWeight', 'bold');

    % Calculate sorted result
    sorted = full(sum(s_gravity, 2))';

    % Subplot 3: Bar chart of sorted result
    subplot(1, 3, 3);
    bar(sorted, 'FaceColor', [0.2 0.6 0.8]);
    xlabel('Position', 'FontSize', 12);
    ylabel('Value', 'FontSize', 12);
    title('Step 3: Sorted Output', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;

    % Add overall title
    sgtitle('Gravity Sort: Visual Step-by-Step Process', 'FontSize', 16, 'FontWeight', 'bold');
end

function visualize_beads(matrix, titleStr)
    % Visualize the bead matrix
    % Beads (1s) are shown as filled circles, empty spaces (0s) are white

    [rows, cols] = size(matrix);

    % Limit visualization size for readability
    maxCols = min(cols, 100);
    matrix = matrix(:, end-maxCols+1:end);  % Show rightmost columns (where beads are)

    % Create image with color mapping
    imagesc(matrix);
    colormap(flipud([1 1 1; 0.2 0.4 0.6]));  % White for 0, Blue for 1
    axis equal tight;

    % Add grid lines
    hold on;
    for i = 0.5:1:rows+0.5
        plot([0.5, maxCols+0.5], [i, i], 'Color', [0.8 0.8 0.8], 'LineWidth', 0.5);
    end
    for j = 0.5:1:maxCols+0.5
        plot([j, j], [0.5, rows+0.5], 'Color', [0.8 0.8 0.8], 'LineWidth', 0.5);
    end
    hold off;

    % Labels
    xlabel('Columns (Height)', 'FontSize', 10);
    ylabel('Rows (Numbers)', 'FontSize', 10);

    % Adjust ticks for better readability
    if rows <= 20
        yticks(1:rows);
    end
    if maxCols <= 50
        set(gca, 'XTick', 1:5:maxCols);
    end

    set(gca, 'YDir', 'normal');  % Flip Y axis so row 1 is at bottom
end
