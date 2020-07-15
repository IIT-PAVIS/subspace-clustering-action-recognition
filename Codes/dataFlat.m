% dataNorm - flatten data into an array, to obtain a new matrix of size [samples, concatenated_features].
%
% Giancarlo Paoletti
% Copyright 2020 Giancarlo Paoletti (giancarlo.paoletti@iit.it)
% Please, email me if you have any question.

function Xf = dataFlat(X)
    for i = 1:size(X,1)
        for j = 1:size(X{i,1},3)
            temp(j,:) = reshape(X{i,1}(:,:,j).',1,[]);
        end
        Xf(i,:) = reshape(temp',[],1)';
        clear temp
    end
end
