function [row, col] = BattleshipAI(board_display, hit_display, lastHitRow, lastHitCol)

%{
Inputs:
- board_display: the game board
- hit_display: Matrix tracking hit and misses
- lastHitRow: Row of last successful hit (-1 if none)
- lstHitCol: same as above
%}
    
    % If we have a previous hit, try adjacent cells
    if lastHitRow ~= -1 && lastHitCol ~= -1
        % Try all four directions around the last hit
        directions = [
            0, 1;   % right
            0, -1;  % left
            1, 0;   % down
            -1, 0   % up
        ];
        
        % Shuffle directions randomly
        directions = directions(randperm(4), :);
        
        % Try each direction
        for i = 1:4
            newRow = lastHitRow + directions(i, 1);
            newCol = lastHitCol + directions(i, 2);
            
            % Check if this is a valid move
            if isValidMove(newRow, newCol, hit_display)
                row = newRow;
                col = newCol;
                return;
            end
        end
    end
    
    % If no valid moves around last hit, or no previous hit,
    % make a random move in an untried location
    while true
        row = randi(10);
        col = randi(10);
        if isValidMove(row, col, hit_display)
            return;
        end
    end
end

function valid = isValidMove(row, col, hit_display)
    % Check if the move is valid (within bounds and not tried before)
    valid = row >= 1 && row <= 10 && ... % within bounds
            col >= 1 && col <= 10 && ... % within bounds
            hit_display(row, col) == 1;   % not tried before
end