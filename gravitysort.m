% Gravity Sort - Optimized Version
tic

n       = 2.5e3;                            % Number of integers
r       = 1e5;                              % Range of integers (from 1 to r)

rng default                                 % Default random number generator

data    = randi(r, 1, n);                   % Random data generation
maxVal  = max(data);                        % Cache max value
dataLen = length(data);                     % Cache data length

% Pre-allocate for efficiency
totalElements = sum(data);                  % Total number of 1s in matrix
rowIdx = zeros(1, totalElements);
colIdx = zeros(1, totalElements);

% Build row and column indices for sparse matrix efficiently
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

% Create sparse matrix in one go
s = sparse(rowIdx, colIdx, 1, dataLen, maxVal);

% Optimized gravity simulation
colSums = full(sum(s, 1));                  % Compute column sums once

% Find non-empty columns
nonZeroCols = find(colSums > 0);
numNonZero = length(nonZeroCols);

% Pre-allocate for gravity-applied matrix
totalElements2 = sum(colSums(nonZeroCols));
rowIdx2 = zeros(1, totalElements2);
colIdx2 = zeros(1, totalElements2);

% Rebuild sparse matrix with gravity applied (beads at bottom)
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

sorted  = full(sum(s, 2))';                 % Convert back to full for final sum

toc
