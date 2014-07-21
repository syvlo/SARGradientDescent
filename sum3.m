function [ M ] = sum3( M, k )
%SUM3 Summary of this function goes here
%   Detailed explanation goes here
% for Scilab compatibility

if nargin<2
    k = 3;
end
M = sum(M,k);

end

