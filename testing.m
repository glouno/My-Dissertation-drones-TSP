%%% TESTING GROUND %%%

Matrix = [1, 2.5; 3, 4; 0, 2];
disp(Matrix);

adjacencyMatrix = pdist(Matrix);
disp(adjacencyMatrix);

output = hypot(Matrix(:,1), Matrix(:, 2)); %quicker way to compute the distance (hypotenuse)
disp(output);

%%% FUNCTION CODE %%%
mapLength = 5;
eventsX = mapLength*rand(10,1) ; eventsY = mapLength*rand(10,1) ; %Events are circles
droneX = 0.5*mapLength ; droneY = 0.5*mapLength ; %Drones are crosses
%use pdist here
adjacencyMatrix2 = pdist2(eventsX-droneX, eventsY-droneY); %using it wrong
disp(adjacencyMatrix2);
output = hypot(eventsX-droneX, eventsY-droneY); %quicker way to compute the distance (hypotenuse)
disp(output);

fprintf("Now testing new adjacency Matrix\n");
disp(length(eventsX));
newAdjacencyMatrix = zeros(length(eventsX)+length(droneX)); %preallocating space required for array
disp(newAdjacencyMatrix);
%by hand

nodesX = [droneX; eventsX];
disp(nodesX);
nodesY = [droneY; eventsY];

nodesXY = [nodesX nodesY];

for i = 1:length(nodesX)
    for j = 1:length(nodesY)
        newAdjacencyMatrix(i, j) = hypot(nodesX(i)-nodesX(j), nodesY(i)-nodesY(j));
    end
end
disp(newAdjacencyMatrix);

%%% TESTING GRAPHS %%%

Graph = graph(newAdjacencyMatrix);
%Graph.Nodes.Names(1) = "Drone 1"; %doesn't really work
plot(Graph);
%pause(5);

%plotting graph Using coordinates
nodesXY = [nodesX nodesY];

gplot(newAdjacencyMatrix, nodesXY); %plots the graph using coordinates but without displaying names


%%% TESTING SEARCHES %%%

depth = dfsearch(Graph, 1, 'allevents')
short = shortestpath(Graph, 1, 10)
%distance = distances(Graph) %literally creates my adjacency matrix
mf = maxflow(Graph, 1, 10) %nothing related but it's cool

shortestHamiltonianCycle = shortestpathtree(Graph, 1, 'all', 'Method', 'positive')
%plot(shortestHamiltonianCycle)

