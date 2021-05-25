function [output] = Simulation(mapLength,durationOfSim, startingEvents, probNewEvents)
%SIMULATION Travelling Salesman Problem with random events
%   Detailed explanation goes here

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

for i = 1:length(nodesXY)   %computes the distance (hypotenuse) between each point
    newAdjacencyMatrix(:, i) = hypot(nodesXY(i,1)-nodesXY(:,1), nodesXY(i,2)-nodesXY(:,2));
end
disp(newAdjacencyMatrix);

%% Drone Energy & Displacement
maxEnergy = 2304000; % max energy in Joules from a 640Wh battery
energy = 2304000; %create an array instead when I have multiple drones
c1 = 0.015;  %characteristics of the Penguin C UAS  
c2 = 2226.5;
velocity = 22; % the drone's speed is 22m/s
%energy = time(c1*velocity^3 + c2/velocity); %time in second means we can
%get rid of it and just implement the equation 

%The full energy level (and the distance able to go) should never be less
%than mapLength, otherwise there are points that you would never be able to
%reach even if you just went for them and came back.

%CAREFUL WHEN I HAVE MULTIPLE DRONES!!! they might need to all have
%separate adjacency matrices, because they shouldn't be allowed to "look
%for" / go towards one another...

%% TESTING
[distance, pathAdjacencyMatrix] = nearestNeighbourNNA(nodesXY, newAdjacencyMatrix, 1);

%% Simulation
for i = 1:durationOfSim
    if rand(1, 1)<=probNewEvents %this can create one more event at the start
        newEvent = mapLength*rand(1,2);
        eventsXY = [eventsXY; newEvent]; %create a new event (no preallocation?)
        nodesXY = [nodesXY; newEvent];
        newAdjacencyMatrix(end+1,end+1) = 0; %creates the correctly sized array
        newAdjacencyMatrix(:, end) = hypot(nodesXY(end,1)-nodesXY(:,1), nodesXY(end,2)-nodesXY(:,2));
        newAdjacencyMatrix(end, :) = newAdjacencyMatrix(:, end); %it is symmetric so we don't need to compute twice
    end
    set(Events, 'XData', eventsXY(:, 1), 'YData', eventsXY(:, 2));
    set(Drones, 'XData', dronesXY(:, 1), 'YData', dronesXY(:, 2));
    drawnow
    %figure(2); %this seperates the graph but we don't have the points
    %anymore
    %gplot(newAdjacencyMatrix, nodesXY); %plots the graph using coordinates but without displaying names
    gplot(pathAdjacencyMatrix, nodesXY); 
    disp(i) %to show time passing
    pause(1) %makes the 1 second pause
end



%%% TESTING %%%



end

