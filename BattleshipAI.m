
function [row, col] = BattleshipAI(board_display, hit_display, lastHit, shipOrientation)

%{
BattleshipAI
Input:
    hit_display: Matrix tracking hits and misses
    lastHit: Structure containing info about last successful hit
    shipOrientation: Know orientation of ship being targeted (0=unknown,
    1=horizontal, 2=vettical)
%}

    
    % Constants for sprite types
    WATER = 2;
    HIT = 9;
    MISS = 10;
    
    % If we have a previous hit, try to sink that ship
    if ~isempty(lastHit) && lastHit.row > 0
        [row, col] = targetShip(board_display, hit_display, lastHit, shipOrientation);
        return;
    end
    
    % If no previous hits, use probability density hunting
    [row, col] = probabilityHunt(board_display, hit_display);
end

function [row, col] = targetShip(board_display, hit_display, lastHit, shipOrientation)
    % Try adjacent cells based on known orientation
    directions = getDirectionsToTry(shipOrientation);
    
    for i = 1:length(directions)
        newRow = lastHit.row + directions(i).dy;
        newCol = lastHit.col + directions(i).dx;
        
        % Check if the cell is valid and hasn't been tried
        if isValidCell(newRow, newCol) && hit_display(newRow, newCol) == 1
            row = newRow;
            col = newCol;
            return;
        end
    end
    
    % If no valid moves found, fall back to probability hunting
    [row, col] = probabilityHunt(board_display, hit_display);
end

function directions = getDirectionsToTry(shipOrientation)
    % Returns directions to check based on known ship orientation
    if shipOrientation == 1  % Horizontal
        directions = [
            struct('dx', 1, 'dy', 0),
            struct('dx', -1, 'dy', 0)
        ];
    elseif shipOrientation == 2  % Vertical
        directions = [
            struct('dx', 0, 'dy', 1),
            struct('dx', 0, 'dy', -1)
        ];
    else  % Unknown orientation
        directions = [
            struct('dx', 0, 'dy', 1),
            struct('dx', 0, 'dy', -1),
            struct('dx', 1, 'dy', 0),
            struct('dx', -1, 'dy', 0)
        ];
    end
end

function [row, col] = probabilityHunt(board_display, hit_display)
    % Create probability density map
    probMap = zeros(10, 10);
    shipLengths = [5, 4, 3, 3, 2];
    
    % Calculate probability for each cell
    for r = 1:10
        for c = 1:10
            if hit_display(r, c) == 1  % Untried cell
                % Check horizontal placement probability
                for shipLen = shipLengths
                    probMap(r, c) = probMap(r, c) + ...
                        calculateShipPlacement(board_display, hit_display, r, c, shipLen, true);
                end
                
                % Check vertical placement probability
                for shipLen = shipLengths
                    probMap(r, c) = probMap(r, c) + ...
                        calculateShipPlacement(board_display, hit_display, r, c, shipLen, false);
                end
            end
        end
    end
    
    % Find highest probability cell
    [maxProb, maxIdx] = max(probMap(:));
    [row, col] = ind2sub(size(probMap), maxIdx);
end

function prob = calculateShipPlacement(board_display, hit_display, row, col, shipLength, isHorizontal)
    % Calculate probability of a ship placement at given position
    prob = 0;
    
    if isHorizontal
        if col + shipLength - 1 <= 10
            % Check if placement is valid
            range = col:(col + shipLength - 1);
            if all(hit_display(row, range) == 1)
                prob = 1;
            end
        end
    else
        if row + shipLength - 1 <= 10
            % Check if placement is valid
            range = row:(row + shipLength - 1);
            if all(hit_display(range, col) == 1)
                prob = 1;
            end
        end
    end
end

function valid = isValidCell(row, col)
    % Check if cell coordinates are within bounds
    valid = row >= 1 && row <= 10 && col >= 1 && col <= 10;
end
