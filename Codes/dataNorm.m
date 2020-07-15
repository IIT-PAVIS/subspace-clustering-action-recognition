% dataNorm - normalize data in range 0~1.
%
% Giancarlo Paoletti
% Copyright 2020 Giancarlo Paoletti (giancarlo.paoletti@iit.it)
% Please, email me if you have any question.

function data = dataNorm(data)
    for i=1:size(data,1)
        for j=1:size(data{i,1},3)
            data{i,1}(1,:,j) = normalize(data{i,1}(1,:,j), 'range', [0,1]);
            data{i,1}(2,:,j) = normalize(data{i,1}(2,:,j), 'range', [0,1]);
            data{i,1}(3,:,j) = normalize(data{i,1}(3,:,j), 'range', [0,1]);
        end
    end
end
