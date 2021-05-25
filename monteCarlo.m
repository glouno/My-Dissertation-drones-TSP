%% MONTE CARLO SIMULATION 

mapLength = 5;
durationOfSim = 10;
startingEvents = 8;
probNewEvents = 0.5;

%keep mapLength fixed for now
%what to do about duration of sim? we want to reach a stable configuration,
%so first try with a long duration and see how it stabilises very important

%probability new events is fixed when users ask but we can change it to see
%the different data points.

%{
for speed = 15:31
    for x = 1:100   %this is to have a sample size of 100 
        MCspeed = output + something average idk.

%}
nbP = 60;    %max number of points on the monte carlo graph 
nbX = 5;    %number of iterations / sample size for each point
NNAdistance = zeros(nbX, nbP); %+1 is for the row above to write 1, 2, 3...
OPTdistance = zeros(nbX, nbP);
bruteTSP = zeros(nbX, nbP);

for nbPoints = 2:nbP
    for x = 1:nbX    %this is the sample size per point
        eventsXY = mapLength*rand(nbPoints, 2);   %Events are circles
        eventsXY(1,:) = [0.5*mapLength 0.5*mapLength]; %makes sure the first node is the base
        AdjacencyMatrix = zeros(length(eventsXY)); %preallocating space required for array
        for i = 1:length(eventsXY)   %computes the distance (hypotenuse) between each point
            AdjacencyMatrix(:, i) = hypot(eventsXY(i,1)-eventsXY(:,1), eventsXY(i,2)-eventsXY(:,2));
        end
        %disp(AdjacencyMatrix);
        
        [NNAdistance(x, nbPoints), NNApathAdjacencyMatrix] = nearestNeighbourNNA(eventsXY, AdjacencyMatrix, 1); %cpath is set to 1 because the base is there
        [OPTpath, OPTdistance(x, nbPoints)] = tspsearch(eventsXY, 1); %this is actually really good
        %writematrix(eventsXY)
        %[bruteTSP(x, nbPoints)] = tsp_brute('eventsXY.txt');
        
    end
end



%[output] = Simulation(mapLength,durationOfSim, startingEvents, probNewEvents);

% output: MCspeed, MCavgRespTime, MCavgEnergyCons, ...