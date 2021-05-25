%%% TESTING GROUND 2222222 %%%
mapLength = 5;
startingEvents = 10;

eventsXY = mapLength*rand(startingEvents, 2);   %Events are circles
dronesXY = [0.5*mapLength 0.5*mapLength];   %Drones are crosses

%% Displaying the map with coordinates (using scatter graph)
Events = scatter(eventsXY(:, 1),eventsXY(:, 2),'o', 'Filled') ; %events
xlim([0 mapLength]); ylim([0 mapLength]);
hold on;
Drones = scatter(dronesXY(:, 1),dronesXY(:, 2),80, 'x', 'red', 'LineWidth', 2.5) ; %drones
xlim([0 mapLength]); ylim([0 mapLength]);

%% Preparing graph
nodesXY = [dronesXY; eventsXY];
newAdjacencyMatrix = zeros(length(nodesXY)); %preallocating space required for array

for i = 1:length(nodesXY)
    for j = 1:length(nodesXY)
        newAdjacencyMatrix(i, j) = hypot(nodesXY(i,1)-nodesXY(j,1), nodesXY(i,2)-nodesXY(j,2));
    end
end
disp(newAdjacencyMatrix);

%% TESTING

output = hypot(eventsX-droneX, eventsY-droneY); %quicker way to compute the distance (hypotenuse)
disp(output);

newAdjacencyMatrix2 = zeros(length(nodesXY)); %preallocating space required for array

for i = 1:length(nodesXY)
    newAdjacencyMatrix2(:, i) = hypot(nodesXY(i,1)-nodesXY(:,1), nodesXY(i,2)-nodesXY(:,2));
    
end
disp(newAdjacencyMatrix2);

