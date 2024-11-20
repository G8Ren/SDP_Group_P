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
hit_display = ones(10,21);
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
hitCountComputer = 0;
winner = "";


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

%Horizontal orientation of ship
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
%Vertical orientation of ship
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

battleship_blank = simpleGameEngine('Battleship.png',84,84);
drawScene(battleship_blank,board_display);
figure(3)
title('Pass Computer to Player 1 and Hit Enter')
waitforbuttonpress

figure(1);



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
hitCountComputer = 0;
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

    % display direction to help player to choose orientation of ship
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

%horizontal orientation of ship
    if (isequal(orientationInput, 'h'))
        title(msgHorizontal);
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_scn);
            % Place the ship if there's enough spaces

            if (c < 11 && (sum(board_display(r,c:(c+ship_length ...
                    (ship_id)-1))) == ship_length(ship_id) * 2))
%place ship
                board_display(r,c:(c+ship_length(ship_id)-1)) = 4;
                board_display(r,c) = 3;
                board_display(r,(c+ship_length(ship_id)-1)) = 5;
                ship_placed = 1;
                drawScene(battleship_scn,board_display);

            end
        end
%vertical orientation of ship
    elseif (isequal(orientationInput, 'v'))
        title(msgVertical)
        while(~ship_placed)
            [r,c] = getMouseInput(battleship_scn);

            % place the ship if the there's enough spaces
            

            if (r < 11 && (sum(board_display(r:(r+ship_length ...
                    (ship_id)-1),c)) == ship_length(ship_id) * 2))
%places ship
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


%Initialize variables 
playerTurn = 1;
shipHit = 0;
secondHit = 0;
lastGuessR = 0;
lastGuessC = 0;
validHit = 0;
validCount = 0;



% Start game loop - go until someone wins
while (gameOver == 0)

    while(playerTurn == 1) %While loop for Player1's turn

        [r,c] = getMouseInput(battleship_scn); 
        if (c > 11 && c < 22 && r > 0 && r < 11)%Checks if on game board 
            if (opponentBoard(r,c-11) ~= 0) %For hit sprite
                hit_display(r,c) = 9; 
                drawScene(battleship_scn, board_display, hit_display);
                %Add 1 to hitcount
                hitCountPlayer = hitCountPlayer + 1;
            else %For miss sprite
                hit_display(r,c) = 10;
                drawScene(battleship_scn, board_display, hit_display);
            end
            
            %If user hits all parts of the ships, end game.
            if (hitCountPlayer == 17)
                winner = "Player 1";
                gameOver = 1;
            end
%End player's turn
            playerTurn = 0;

        end
    end  %computer's turn
    while(playerTurn == 0)
        validHit = 0; %Initialize flag 
        if (shipHit == 1 )
            if (secondHit == 1) %Computer to guess near hit

    
            else


            end
            while(validHit ~= 1)
                % Guess spaces around the hit
                guessR = randi(2,1);
                guessC = randi(2,1);
                if (guessR == 1 && guessC == 1) 

                elseif (guessR == 2 && guessC == 1)

                elseif (guessR == 1 && guessC == 2)

                else
                    
                end
                    
            end
            

        else %if the computer has not made a hit yet then random guess
            while(validHit~=1) 
                randomR = randi(10,1);
                randomC = randi(10,1);
                if (board_display(randomR, randomC) ~= 2 && ...
                        hit_display(randomR, randomC) == 1)
                    hit_display(randomR, randomC) = 9;
                    validHit = 1;
                    validCount = validCount + 1;
                    shipHit = 1;
                    lastGuessR = randomR;
                    lastGuessC = randomC;

%computer to check to make sure area hasn't been hit yet
                elseif (board_display(randomR, randomC) == 2 && ...
                        hit_display(randomR, randomC) == 1)
                    hit_display(randomR, randomC) = 10;
                    validHit = 1;
                end
                drawScene(battleship_scn,board_display, hit_display);
%turn goes back to player1 
                playerTurn = 1;
            end
        end
        


    end


end
end
