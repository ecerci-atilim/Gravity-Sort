% Gravity Sort with Smooth Animation
% This version animates the beads falling through gravity

function gravitysort_animated()
    % Parameters
    n       = 15;                               % Number of integers
    r       = 30;                               % Range of integers

    rng default                                 % Default random number generator

    data    = randi(r, 1, n);                   % Random data generation

    fprintf('Animated Gravity Sort\n');
    fprintf('=====================\n');
    fprintf('Input data: ');
    disp(data);
    fprintf('\n');

    % Run gravity sort with animation
    sorted = gravity_sort_animated(data);

    fprintf('\nSorted data: ');
    disp(sorted);
    fprintf('\nVerification: ');
    if isequal(sorted, sort(data))
        fprintf('✓ Correctly sorted!\n');
    else
        fprintf('✗ Sort failed!\n');
    end
end

function sorted = gravity_sort_animated(data)
    maxVal = max(data);
    dataLen = length(data);

    % Build initial bead matrix
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
    initial_matrix = full(s);

    % Calculate final positions after gravity
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

    s_final = sparse(rowIdx2, colIdx2, 1, dataLen, maxVal);
    final_matrix = full(s_final);

    % Create figure for animation
    fig = figure('Name', 'Animated Gravity Sort', 'Position', [100, 100, 1400, 700]);

    % Animate the gravity process column by column
    num_frames = 30;

    for frame = 1:num_frames
        t = frame / num_frames;  % Progress from 0 to 1

        % Interpolate between initial and final states
        current_matrix = animate_gravity(initial_matrix, final_matrix, t);

        clf;

        % Left panel: Bead visualization
        subplot(1, 2, 1);
        visualize_beads_animated(current_matrix, sprintf('Gravity Simulation (%.0f%%)', t*100));

        % Right panel: Bar chart showing current row sums
        subplot(1, 2, 2);
        current_sums = sum(current_matrix, 2)';
        bar(current_sums, 'FaceColor', [0.2 0.6 0.8], 'EdgeColor', [0.1 0.4 0.6]);
        xlabel('Position', 'FontSize', 12);
        ylabel('Value', 'FontSize', 12);
        title('Current Row Sums', 'FontSize', 14, 'FontWeight', 'bold');
        ylim([0, maxVal + 5]);
        grid on;

        % Overall title
        sgtitle('Gravity Sort Animation: Watch the Beads Fall!', 'FontSize', 16, 'FontWeight', 'bold');

        drawnow;
        pause(0.05);  % Adjust speed of animation
    end

    % Final display
    clf;
    subplot(1, 2, 1);
    visualize_beads_animated(final_matrix, 'Final State');

    subplot(1, 2, 2);
    sorted = sum(final_matrix, 2)';
    bar(sorted, 'FaceColor', [0.2 0.8 0.4], 'EdgeColor', [0.1 0.6 0.3]);
    xlabel('Position', 'FontSize', 12);
    ylabel('Value', 'FontSize', 12);
    title('✓ Sorted Output', 'FontSize', 14, 'FontWeight', 'bold');
    ylim([0, maxVal + 5]);
    grid on;

    sgtitle('Gravity Sort Complete!', 'FontSize', 16, 'FontWeight', 'bold');
end

function interpolated = animate_gravity(initial, final, t)
    % Animate beads falling using easing function
    % t goes from 0 to 1

    % Use ease-in-out for smooth motion
    t_eased = ease_in_out(t);

    [rows, cols] = size(initial);
    interpolated = zeros(rows, cols);

    % For each column, animate beads falling to their final positions
    for col = 1:cols
        initial_col = initial(:, col);
        final_col = final(:, col);

        % Find positions of beads in initial and final states
        initial_beads = find(initial_col);
        final_beads = find(final_col);

        if length(initial_beads) == length(final_beads)
            % Interpolate bead positions
            for b = 1:length(initial_beads)
                start_row = initial_beads(b);
                end_row = final_beads(b);

                % Calculate current position with easing
                current_row = round(start_row + (end_row - start_row) * t_eased);
                interpolated(current_row, col) = 1;
            end
        end
    end
end

function y = ease_in_out(t)
    % Smooth easing function for animation
    if t < 0.5
        y = 2 * t * t;
    else
        y = 1 - 2 * (1 - t) * (1 - t);
    end
end

function visualize_beads_animated(matrix, titleStr)
    % Visualize the bead matrix with enhanced graphics
    [rows, cols] = size(matrix);

    % Limit visualization size for readability
    maxCols = min(cols, 100);
    matrix = matrix(:, end-maxCols+1:end);

    % Create colored visualization
    img = ones(rows, maxCols, 3);  % RGB image

    for i = 1:rows
        for j = 1:maxCols
            if matrix(i, j) == 1
                % Blue beads
                img(i, j, :) = [0.2, 0.5, 0.9];
            end
        end
    end

    imagesc(img);
    axis equal tight;

    % Add grid lines
    hold on;
    for i = 0.5:1:rows+0.5
        plot([0.5, maxCols+0.5], [i, i], 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    end
    for j = 0.5:1:maxCols+0.5
        plot([j, j], [0.5, rows+0.5], 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    end
    hold off;

    xlabel('Columns', 'FontSize', 11);
    ylabel('Rows', 'FontSize', 11);
    title(titleStr, 'FontSize', 14, 'FontWeight', 'bold');

    if rows <= 20
        yticks(1:rows);
    end

    set(gca, 'YDir', 'normal');
end
