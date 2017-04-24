function [ sum_squared_error ] = find_sum_squared_error( point_set1, point_set2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Check that dimensions of inputs match
if( size(point_set1) ~= size(point_set2) )
    sum_squared_error = -1;
    return;
end

error_set = point_set1 - point_set2;
error_set = error_set.^2;
sum_squared_error = sum(sum(error_set));

end

