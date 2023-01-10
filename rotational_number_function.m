function [h] = rotational_number_function(n,F)
%ROTATIONAL_NUMBER_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
h = (F(:,n)-F(:,1)) / n;
end

