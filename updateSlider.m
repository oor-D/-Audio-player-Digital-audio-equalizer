function updateSlider(~, ~, app, audioFile, totalTime)
% updateSlider This function is called every 0.05 seconds by an audioplayer
% object. When it is run, it slightly increments the position of the
% slider, and changes the text of the time labels to match the position in
% the song

%Calculate new position to move slider to, and check that it is in
%bounds

currentPosition = get(app.timeBar, 'Value'); %Gets current position of the slider
newPosition = currentPosition + audioFile.TimerPeriod / totalTime; %Calculates position to move the slider to

%Check that newPosition is within min/max bounds
if (newPosition > 1)
    newPosition = 1;
end

set(app.timeBar, 'Value', newPosition); %Updates position of the slider

% Change numbers

% %First, calculate the time into the song
totalTime = audioFile.TotalSamples / audioFile.SampleRate; %In seconds
newTime = totalTime * newPosition; % 0 < newPosition < 1

axis(app.timeUIAxes,[newTime-2,newTime+2,-1,1]);
xticks(app.timeUIAxes,newTime);
xticklabels(app.timeUIAxes,{''});
if audioFile.NumberOfChannels==2
    axis(app.timeUIAxes_2,[newTime-2,newTime+2,-1,1]);
    xticks(app.timeUIAxes_2,newTime);
    xticklabels(app.timeUIAxes_2,{''});
end
%Update labels

%Calculate time into the song
[hours, minutes, seconds] = hoursMinsSecs(newTime);

% Update time label
timeElapsedString = strcat(num2str(hours,'%02.0f'), ':', num2str(minutes,'%02.0f'), ':', num2str(seconds,'%02.0f'));
set(app.timeElapsed, 'Text', timeElapsedString)


%Calculate time left in the song
[hoursLeft, minutesLeft, secondsLeft] = hoursMinsSecs(totalTime - newTime);

% Update time label
timeLeftString = strcat('-', num2str(hoursLeft,'%02.0f'), ':', num2str(minutesLeft,'%02.0f'), ':', num2str(secondsLeft,'%02.0f'));
set(app.timeLeft, 'Text', timeLeftString)