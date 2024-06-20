function [ hours, minutes, seconds ] = hoursMinsSecs( inputSeconds )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

hours = floor(inputSeconds/ 3600);
minutes = floor((inputSeconds - hours * 3600) / 60);
seconds = inputSeconds - hours * 3600 - minutes * 60;

end

