%% Static Cluster Simulation

mapLength = 100000;
startingEvents = 100;

%% Drone Energy & Displacement
maxEnergy = 2304000; % max energy in Joules from a 640Wh battery
energy = 2304000; %create an array instead when I have multiple drones
c1 = 0.015;  %characteristics of the Penguin C UAS  
c2 = 2226.5;
velocity = 22; % the drone's speed is 22m/s
%energy = time(c1*velocity^3 + c2/velocity); %time in second means we can
%get rid of it and just implement the equation 

%use distance (the weights) and the velocity to compute time
%actualTime = OPTclusterdistance/velocity
maxTime = maxEnergy/(c1*velocity^3 + c2/velocity); %in seconds
maxDistance = velocity * maxTime; %in meters


%% Generating events
eventsXY = mapLength*rand(startingEvents, 2);   %Events are circles
dronesXY = [0.5*mapLength 0.5*mapLength];   %Drones are crosses

%% Displaying the map with coordinates (using scatter graph)
Events = scatter(eventsXY(:, 1),eventsXY(:, 2),'o', 'Filled') ; %events
xlim([0 mapLength]); ylim([0 mapLength]);
hold on;
Drones = scatter(dronesXY(:, 1),dronesXY(:, 2),80, 'x', 'red', 'LineWidth', 2.5) ; %drones
xlim([0 mapLength]); ylim([0 mapLength]);

set(Events, 'XData', eventsXY(:, 1), 'YData', eventsXY(:, 2));
set(Drones, 'XData', dronesXY(:, 1), 'YData', dronesXY(:, 2));
drawnow


flag = true;
numberOfClusters = 4;

while flag == true

%% Testing normal clustering
[idx, C, sumd, D] = kmeans(eventsXY, numberOfClusters)
figure(2)
gscatter(eventsXY(:,1),eventsXY(:,2),idx);
legend('Location','eastoutside');
hold on;
clusterMatrix = cell(1, numberOfClusters);

%% Partitioning clusters into seperate matrices
for i = 1:length(eventsXY)
    clusterMatrix{idx(i)} = [clusterMatrix{idx(i)}; eventsXY(i, :)];
end

%% Computing path length
OPTclusterdistance = zeros(numberOfClusters, 1);
for i = 1:numberOfClusters
    clusterMatrix{i} = [0.5*mapLength 0.5*mapLength; clusterMatrix{i}];
    [OPTclusterpath, OPTclusterdistance(i)] = tspsearch(clusterMatrix{i}, 1);
    
    clusterAdjacencyMatrix = zeros(length(clusterMatrix{i})); %preallocating space required for array
    for j = 2:length(OPTclusterpath)   % create adjacency matrix based on path
    clusterAdjacencyMatrix(OPTclusterpath(j-1), OPTclusterpath(j)) = hypot(clusterMatrix{i}(OPTclusterpath(j-1),1)-clusterMatrix{i}(OPTclusterpath(j),1), clusterMatrix{i}(OPTclusterpath(j-1),2)-clusterMatrix{i}(OPTclusterpath(j),2));
    end
    %complete the cycle: (link the end to the beginning)
    clusterAdjacencyMatrix(OPTclusterpath(end), OPTclusterpath(1)) = hypot(clusterMatrix{i}(OPTclusterpath(end),1)-clusterMatrix{i}(OPTclusterpath(1),1), clusterMatrix{i}(OPTclusterpath(end),2)-clusterMatrix{i}(OPTclusterpath(1),2));
    gplot(clusterAdjacencyMatrix, clusterMatrix{i}); % display paths as tey are computed
    pause(0.1) %artificial pause to see the progression of the paths
end

if max(OPTclusterdistance) > maxDistance
    numberOfClusters = numberOfClusters + 1; %the distance is too long so we need to seperate one cluster by adding one more

    %here we could add a second if statement for the average response time
    %requirement
else
    flag = false; % the distance is not too long
end
    
pause(2) %two second pause to see the graph changing as clusters are added
hold off;

end
%% Relation between sumd and OPTclusterdistance

%% Energy Based clustering

