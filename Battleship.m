%Clear everything before the game starts.
clc
clear
close all

%-----------------------------------------------------
% Battleship Game
% Team P (Jun Jin, AJ Brewer, Tyler Fu, Thomas Wu)
%
% This document contains the implementation of a
% text-based version of the classic Battleship game.
% Players take turns guessing coordinates to hit
% their opponent's ships until one player wins.
%-----------------------------------------------------


% Let user decide if they want to play the computer or have a player 2
tab = 999;
backspace = 9999;

% Display empty board
% Set up variables to make it easier to identify which is which.
blank_sprite = 1;
water_sprite = 2;
left_ship_sprite = 3;
horiz_ship_sprite = 4;
right_ship_sprite = 5;
top_ship_sprite = 6;
vert_ship_sprite = 7;
bot_ship_sprite = 8;
hit_sprite = 9;
miss_sprite = 10;

board_display = water_sprite * ones(10,21);
hit_display1 = ones(10,21);
hit_display2 = ones(10,21);
board_display(:,11) = blank_sprite;

battleship_blank = simpleGameEngine('Battleship.png',84,84);
drawScene(battleship_blank,board_display);
title('Press Space for 2 Player, Press Any Other Button To Play the Computer')

k = waitforbuttonpress;
value = double(get(gcf, 'CurrentCharacter'));
if value == 32
    fprintf('2 Player Selected \n \n')

    pause(0.5)

    close all

    % Initialize scene
battleship_p1 = simpleGameEngine('Battleship.png',84,84);
battleship_p2 = simpleGameEngine('Battleship.png',84,84);


% Initialize variables
turn = 1;
gameOver = 0;
orientationMsg = "Choose the orientation (H for horizontal or V for " + ...
    "vertical)";
ship_length = [5,4,3,3,2];
hitCountPlayer = 0;
hitCount2 = 0;
winner = "";

hitCountComputer = 0;
lastHitRow = -1;  % Initialize to -1 (no previous hit)
lastHitCol = -1;  % Initialize to -1 (no previous hit)

% Display empty board
board_display1 = water_sprite * ones(10,21);
hit_display = ones(10,21);
board_display1(:,11) = blank_sprite;
drawScene(battleship_p1,board_display1);


% Player places the ships
% Loop over each ships
for ship_id = 1:5
    % initialize varaibles to use in the loop
    valid = 0;
    ship_placed = 0;

    msgHorizontal = "Pick a grid to place the front of the ship " + ...
        "with a length of " + string(ship_length(ship_id)) + ". " + ...
        "Rest of the body will be filled to the right of " + ...
        "the selected grid.";
    msgVertical = "Pick a grid to place the front of the ship " + ...
        "with a length of " + string(ship_length(ship_id)) + ". " + ...
        "Rest of the body will be filled to the bottom of " + ...
        "the selected grid.";

    % display direction to help player to choose orientation
    title(orientationMsg);


    % loop until the input is either h or v
    while(~valid)
        % get the input
        orientationInput = getKeyboardInput(battleship_p1);
        % check if input is either h or v and if it is,
        % set valid = 1
        if (isequal(orientationInput, 'h') || ...
                isequal(orientationInput, 'v'))
            valid = 1;
        end
    end


    if (isequal(orientationInput, 'h'))
        title(msgHorizontal);
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_p1);
            % Place the ship if there's enough spaces

            if (c < 11 && (sum(board_display1(r,c:(c+ship_length ...
                    (ship_id)-1))) == ship_length(ship_id) * 2))

                board_display1(r,c:(c+ship_length(ship_id)-1)) = 4;
                board_display1(r,c) = 3;
                board_display1(r,(c+ship_length(ship_id)-1)) = 5;
                ship_placed = 1;
                drawScene(battleship_p1,board_display1);

            end
        end

    elseif (isequal(orientationInput, 'v'))
        title(msgVertical)
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_p1);

            % Place the ship if the there's enough spaces
            

            if (r < 11 && (sum(board_display1(r:(r+ship_length ...
                    (ship_id)-1),c)) == ship_length(ship_id) * 2))

                board_display1(r:(r+ship_length(ship_id)-1),c) = 7;
                board_display1(r,c) = 6;
                board_display1((r+ship_length(ship_id)-1),c) = 8;
                ship_placed = 1;
                drawScene(battleship_p1,board_display1);

            end
        end
    end
end

% Display empty board
board_display2 = water_sprite * ones(10,21);
hit_display = ones(10,21);
board_display2(:,11) = blank_sprite;
drawScene(battleship_p2,board_display2);





% Player places the ships
% Loop over each ships
for ship_id = 1:5
    % initialize varaibles to use in the loop
    valid = 0;
    ship_placed = 0;

    msgHorizontal = "Pick a grid to place the front of the ship " + ...
        "with a length of " + string(ship_length(ship_id)) + ". " + ...
        "Rest of the body will be filled to the right of " + ...
        "the selected grid.";
    msgVertical = "Pick a grid to place the front of the ship " + ...
        "with a length of " + string(ship_length(ship_id)) + ". " + ...
        "Rest of the body will be filled to the bottom of " + ...
        "the selected grid.";

    % display direction to help player to choose orientation
    title(orientationMsg);


    % loop until the input is either h or v
    while(~valid)
        % get the input
        orientationInput = getKeyboardInput(battleship_p2);
        % check if input is either h or v and if it is,
        % set valid = 1
        if (isequal(orientationInput, 'h') || ...
                isequal(orientationInput, 'v'))
            valid = 1;
        end
    end


    if (isequal(orientationInput, 'h'))
        title(msgHorizontal);
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_p2);
            % Place the ship if there's enough spaces

            if (c < 11 && (sum(board_display2(r,c:(c+ship_length ...
                    (ship_id)-1))) == ship_length(ship_id) * 2))

                board_display2(r,c:(c+ship_length(ship_id)-1)) = 4;
                board_display2(r,c) = 3;
                board_display2(r,(c+ship_length(ship_id)-1)) = 5;
                ship_placed = 1;
                drawScene(battleship_p2,board_display2);

            end
        end

    elseif (isequal(orientationInput, 'v'))
        title(msgVertical)
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_p2);

            % Place the ship if the there's enough spaces
            

            if (r < 11 && (sum(board_display2(r:(r+ship_length ...
                    (ship_id)-1),c)) == ship_length(ship_id) * 2))

                board_display2(r:(r+ship_length(ship_id)-1),c) = 7;
                board_display2(r,c) = 6;
                board_display2((r+ship_length(ship_id)-1),c) = 8;
                ship_placed = 1;
                drawScene(battleship_p2,board_display2);

            end
        end
    end
end

% Figure 1 == P1
% Figure 2 == P2

% Initialize blank scene for switching between P1 and P2
battleship_blank = simpleGameEngine('Battleship.png',84,84);
drawScene(battleship_blank,board_display);
figure(3)
title('Pass Computer to Player 1 and Hit Enter')
waitforbuttonpress
pause(.01)

% Switch to P1 and get mouse input for shot location
turn = 1;
figure(1);
title('Left-click on the right-side grid to choose shot location')
figure(2);
title('Left-click on the right-side grid to choose shot location')

while (gameOver == 0)
    if turn == 1
        figure(1)
        drawScene(battleship_p1, board_display1, hit_display1);
        [r, c] = getMouseInput(battleship_p1);
        if (c > 11 && c <= 21 && r >= 1 && r <= 10)
            shotcol = c - 11;
            if (shotcol >= 1 && shotcol <= 10)  % Ensure shotcol is within the valid range
                if any(board_display2(r, shotcol) == [left_ship_sprite, horiz_ship_sprite, right_ship_sprite, top_ship_sprite, vert_ship_sprite, bot_ship_sprite])  % Correct logical condition
                    hit_display1(r, c) = hit_sprite;
                    board_display2(r, c-11) = hit_sprite;
                    hitCountPlayer = hitCountPlayer + 1;  % Add 1 to hit count
                    drawScene(battleship_p1, board_display1, hit_display1);
                else
                    hit_display1(r, c) = miss_sprite;
                    board_display2(r, c-11) = miss_sprite;
                    drawScene(battleship_p1, board_display1, hit_display1);
                end
                drawScene(battleship_p1, board_display1, hit_display1);
                title('Hit Enter When Ready to Continue')
                waitforbuttonpress
                drawScene(battleship_blank, board_display);
                figure(3)
                title('Pass Computer to Player 2 and Hit Enter')
                waitforbuttonpress
                pause(.01)
                turn = 2;
                % If user hits all parts of the ships, end game.
                if (hitCountPlayer == 17)
                    winner = "Player 1";
                    gameOver = 1;
                end
            end
        else 
            drawScene(battleship_p1, board_display1, hit_display1);
            title('Invalid shot location! Only Select the Hit Grid Using the Mouse')
        end
    else
        figure(2)
        drawScene(battleship_p2, board_display2, hit_display2);
        [r, c] = getMouseInput(battleship_p2);
        if (c > 11 && c <= 21 && r >= 1 && r <= 10)
            shotcol = c - 11;
            if (shotcol >= 1 && shotcol <= 10)  % Ensure shotcol is within the valid range
                if any(board_display1(r, shotcol) == [left_ship_sprite, horiz_ship_sprite, right_ship_sprite, top_ship_sprite, vert_ship_sprite, bot_ship_sprite])  % Correct logical condition
                    hit_display2(r, c) = hit_sprite;
                    hitCount2 = hitCount2 + 1;  % Add 1 to hit count
                    board_display1(r, c - 11) = hit_sprite;
                else
                    hit_display2(r, c) = miss_sprite;
                    board_display1(r, c - 11) = miss_sprite;
                end
                drawScene(battleship_p2, board_display2, hit_display2);
                title('Hit Enter When Ready to Continue')
                waitforbuttonpress
                drawScene(battleship_blank, board_display);
                figure(3)
                title('Pass Computer to Player 1 and Hit Enter')
                waitforbuttonpress
                pause(.01)
                turn = 1;
                % Check if Player 2 has won
                if (hitCount2 == 17)
                    winner = "Player 2";
                    gameOver = 2;
                end
            end
        else
            drawScene(battleship_p2, board_display2, hit_display2);
            title('Invalid shot location! Only Select the Hit Grid Using the Mouse')
        end
    end
end

if gameOver == 1
    winp = 1;
else
    winp = 2;
end

close all
fprintf('\n \n \n Player %.i Wins! \n', winp)


%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------



else
% Initialize scene
battleship_scn = simpleGameEngine('Battleship.png',84,84);


% Set up variables to make it easier to identify which is which.
blank_sprite = 1;
water_sprite = 2;
left_ship_sprite = 3;
horiz_ship_sprite = 4;
right_ship_sprite = 5;
top_ship_sprite = 6;
vert_ship_sprite = 7;
bot_ship_sprite = 8;
hit_sprite = 9;
miss_sprite = 10;


% Initialize variables
turn = 1;
gameOver = 0;
orientationMsg = "Choose the orientation (H for horizontal or V for " + ...
    "vertical)";
ship_length = [5,4,3,3,2];
hitCountPlayer = 0;
hitCount2 = 0;
winner = "";





% Display empty board
board_display = water_sprite * ones(10,21);
hit_display = ones(10,21);
board_display(:,11) = blank_sprite;
drawScene(battleship_scn,board_display);





% Player places the ships
% Loop over each ships
for ship_id = 1:5
    % initialize varaibles to use in the loop
    valid = 0;
    ship_placed = 0;

    msgHorizontal = "Pick a grid to place the front of the ship " + ...
        "with a length of " + string(ship_length(ship_id)) + ". " + ...
        "Rest of the body will be filled to the right of " + ...
        "the selected grid.";
    msgVertical = "Pick a grid to place the front of the ship " + ...
        "with a length of " + string(ship_length(ship_id)) + ". " + ...
        "Rest of the body will be filled to the bottom of " + ...
        "the selected grid.";

    % display direction to help player to choose orientation
    title(orientationMsg);


    % loop until the input is either h or v
    while(~valid)
        % get the input
        orientationInput = getKeyboardInput(battleship_scn);
        % check if input is either h or v and if it is,
        % set valid = 1
        if (isequal(orientationInput, 'h') || ...
                isequal(orientationInput, 'v'))
            valid = 1;
        end
    end


    if (isequal(orientationInput, 'h'))
        title(msgHorizontal);
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_scn);
            % Place the ship if there's enough spaces

            if (c < 11 && (sum(board_display(r,c:(c+ship_length ...
                    (ship_id)-1))) == ship_length(ship_id) * 2))

                board_display(r,c:(c+ship_length(ship_id)-1)) = 4;
                board_display(r,c) = 3;
                board_display(r,(c+ship_length(ship_id)-1)) = 5;
                ship_placed = 1;
                drawScene(battleship_scn,board_display);

            end
        end

    elseif (isequal(orientationInput, 'v'))
        title(msgVertical)
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_scn);

            % Place the ship if the there's enough spaces
            

            if (r < 11 && (sum(board_display(r:(r+ship_length ...
                    (ship_id)-1),c)) == ship_length(ship_id) * 2))

                board_display(r:(r+ship_length(ship_id)-1),c) = 7;
                board_display(r,c) = 6;
                board_display((r+ship_length(ship_id)-1),c) = 8;
                ship_placed = 1;
                drawScene(battleship_scn,board_display);

            end
        end
    end
end

opponentBoard = Setup();

% Initialize AI tracking variables
lastHitRow = -1;
lastHitCol = -1;
hitCountComputer = 0;
gameOver = 0;
playerTurn = 1;
shipHit = 0;
secondHit = 0;
lastGuessR = 0;
lastGuessC = 0;
validHit = 0;
validCount = 0;



% Start game loop - go until someone wins

while (gameOver == 0)

    while(playerTurn == 1) 

        [r,c] = getMouseInput(battleship_scn);
        if (c > 11 && c < 22 && r > 0 && r < 11)
            if (opponentBoard(r,c-11) ~= 0)
                hit_display(r,c) = 9;
                drawScene(battleship_scn, board_display, hit_display);
                %Add 1 to hitcount
                hitCountPlayer = hitCountPlayer + 1;
            else
                hit_display(r,c) = 10;
                drawScene(battleship_scn, board_display, hit_display);
            end
            
            %If user hits all parts of the ships, end game.
            if (hitCountPlayer == 17)
                winner = "Player 1";
                gameOver = 1;
            end

            playerTurn = 0;

        end
    end

    while(playerTurn == 0)
        %get AI's move
        [randomR, randomC] = BattleshipAI(board_display,hit_display,lastHitRow,lastHitCol);

        %make the move
        if board_display(randomR, randomC) ~= 2 %if hit
            hit_display(randomR, randomC) = 9;
            hitCountComputer = hitCountComputer + 1;

            %save the hit for next turn
            lastHitRow = randomR;
            lastHitCol = randomC;
        else %miss
            hit_display(randomR,randomC) = 10;

            if lastHitRow ~= -1
                allMisses = true;
                for dr = -1:1
                    for dc = -1:1
                        r = lastHitRow + dr;
                        c = lastHitCol + dc;
                        if r>=1 && r<=10 && c>=1 && c <=10
                            if hit_display(r,c) ==9
                                allMisses = false;
                                break;
                            end
                        end
                    end
                end
                if allMisses
                    lastHitRow = -1;
                    lastHitCol = -1;
                end
            end
        end

        drawScene(battleship_scn, board_display, hit_display);

        %checks if AI wins
        if hitCountComputer == 17
            winner = "Computer";
            gameOver = 1;
        end

        playerTurn = 1;

    end

end

end    





