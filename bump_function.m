function [w] = bump_function(n,S)
%BUMP_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
w = exp(-1 / (n/S * (1-(n / S))));
end

