% dataPrune - removes (if any) NaN samples, zeros samples or samples with only one timestamp.
%
% Giancarlo Paoletti
% Copyright 2020 Giancarlo Paoletti (giancarlo.paoletti@iit.it)
% Please, email me if you have any question.

function [data, action_label] = dataPrune(data, action_label)
    idxNaNs = []; idxOnes = []; idxZeros = [];
    iNaNs = 1; iOnes = 1; iZeros = 1;
    for iCells=1:size(data,1)
        if size(data{iCells,1},3) == 1
            idxOnes(iOnes,1) = iCells; iOnes = iOnes + 1;
        end
        for iSamples=1:size(data{iCells,1},3)
            if isnan(data{iCells,1}(1,:,iSamples)) | isnan(data{iCells,1}(2,:,iSamples)) | isnan(data{iCells,1}(3,:,iSamples))
                idxNaNs(iNaNs,1) = iCells; iNaNs = iNaNs + 1;
                break
            end
            if sum(data{iCells,1}(1,:,iSamples))==0 || sum(data{iCells,1}(2,:,iSamples))==0 || sum(data{iCells,1}(3,:,iSamples))==0
                idxZeros(iZeros,1) = iCells; iZeros = iZeros + 1;
                break
            end
        end
    end
    if not(isempty(idxNaNs))
        data(idxNaNs) = []; action_label(idxNaNs) = []; disp('Dataset pruned: all-NaN samples removed.')
    end
    if not(isempty(idxOnes))
        data(idxOnes) = []; action_label(idxOnes) = []; disp('Dataset pruned: all single-timestamp samples removed.')
    end
    if not(isempty(idxZeros))
        data(idxZeros) = []; action_label(idxZeros) = []; disp('Dataset pruned: all-zeros samples removed.')
    end 
end