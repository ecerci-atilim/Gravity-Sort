% Test script to verify gravity sort optimization
fprintf('Testing Gravity Sort Optimization...\n\n');

% Test 1: Small dataset
fprintf('Test 1: Small dataset (n=10, r=20)\n');
n = 10;
r = 20;
rng(42);  % Fixed seed for reproducibility
data = randi(r, 1, n);
fprintf('Input:  ');
disp(data);

% Run optimized gravity sort
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

fprintf('Sorted: ');
disp(sorted);
fprintf('MATLAB sort: ');
disp(sort(data));

% Verify correctness
if isequal(sorted, sort(data))
    fprintf('✓ Test 1 PASSED\n\n');
else
    fprintf('✗ Test 1 FAILED\n\n');
end

% Test 2: Edge cases
fprintf('Test 2: Edge cases\n');
test_cases = {
    [1, 1, 1, 1],
    [5, 4, 3, 2, 1],
    [1, 2, 3, 4, 5],
    [10],
    [5, 5, 5]
};

all_passed = true;
for t = 1:length(test_cases)
    data = test_cases{t};
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

    if ~isequal(sorted, sort(data))
        fprintf('  ✗ Edge case %d FAILED\n', t);
        all_passed = false;
    end
end

if all_passed
    fprintf('✓ Test 2 PASSED (all edge cases)\n\n');
else
    fprintf('✗ Test 2 FAILED\n\n');
end

fprintf('All tests completed!\n');
