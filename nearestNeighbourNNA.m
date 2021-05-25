function [distance, pathAdjacencyMatrix] = nearestNeighbourNNA(nodesXY, newAdjacencyMatrix, cpath)
%nearestNeighbourNNA computing a path using NNA (local optimum, upper
%bound)

%Graph = graph(newAdjacencyMatrix);

distance = 0;
path = zeros(1,length(nodesXY)+1); %preallocate size
pathAdjacencyMatrix = zeros(length(newAdjacencyMatrix));
tmparray = newAdjacencyMatrix;
tmparray( tmparray == 0 ) = NaN;

for j = 1:length(nodesXY)
    path(j) = cpath;
    [tmpdist, tmppath] = min(tmparray(cpath,:));
    if isnan(tmpdist) == true
        distance = distance + newAdjacencyMatrix(path(1), path(j));
        path(end) = path(1);
        %add pathAdjacencyMatrix
    else
        distance = distance + tmpdist;
    end
    tmparray(cpath, :) = NaN;
    tmparray(:, cpath) = NaN;
    
    pathAdjacencyMatrix(cpath, tmppath) = newAdjacencyMatrix(cpath, tmppath); %adjacency Matrix for the NNA calculated path
    %disp(pathAdjacencyMatrix);
    
    cpath = tmppath; %switch current state to the new state
end

%disp(distance)
%disp(path)


%Graph = digraph(pathAdjacencyMatrix);
%gplot(pathAdjacencyMatrix, nodesXY);
%plot(Graph)

end