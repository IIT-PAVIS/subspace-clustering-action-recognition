% dataPlot - graphical representation of results implemented and proposed in [1]
% This function plots the affinity matrix, the confusion matrix and the label mismatching of a given dataset.
%
% --- INPUT ---
%  - grps: predicted cluster labels of the given dataset.
%  - action_label: ground-truth action labels of the given dataset.
%  - dataset: string vector, to be chosen bewtween F3D, UTK, MSRP, MSRA, G3D, HDM-05-14, HDM-05-65, MSRC.
%  - W: d-by-d affinity matrix.
%
% --- OUTPUT ---
%  - Figure(1): a comparison between ground truth labels (upper row)
%               and the predicted cluster labels (bottom row), using a script from [2].
%  - Figure(2): the confusion matrix of the given dataset's ground truth and predicted labels.
%  - Figure(3): a plot of the affinity matrix W.
%
% Giancarlo Paoletti
% Copyright 2020 Giancarlo Paoletti (giancarlo.paoletti@iit.it)
% Please, email me if you have any question.
%
% Disclaimer:
% The software is provided "as is", without warranty of any kind, express or implied, 
% including but not limited to the warranties of merchantability, 
% fitness for a particular purpose and noninfringement. In no event shall the authors, 
% PAVIS or IIT be liable for any claim, damages or other liability, whether in an action of contract, 
% tort or otherwise, arising from, out of or in connection with the software 
% or the use or other dealings in the software.
% 
% LICENSE:
% This project is licensed under the terms of the MIT license.
% This project incorporates material from the projects listed below (collectively, "Third Party Code").
% This Third Party Code is licensed to you under their original license terms.
% We reserves all other rights not expressly granted, whether by implication, estoppel or otherwise.
%
% Copyright (c) 2020 Giancarlo Paoletti, Jacopo Cavazza, Cigdem Beyan and Alessio Del Bue
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
% documentation files (the "Software"), to deal in the Software without restriction, including without
% limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
% the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
% conditions:
% The above copyright notice and this permission notice shall be included in all copies or substantial
% portions of the Software.
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
% LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
% WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% References
% [1] Giancarlo Paoletti, Jacopo Cavazza, Cigdem Beyan and Alessio Del Bue (2020).
%     Subspace Clustering for Action Recognition with Covariance Representations and Temporal Pruning.
%     International Conference on Pattern Recognition (ICPR).
% [2] Li, S., Li, K., & Fu, Y. (2015).
%     Temporal subspace clustering for human motion segmentation.
%     In Proceedings of the IEEE International Conference on Computer Vision (pp. 4453-4461).

function dataPlot(grps, action_label, dataset, W)
    if strcmpi(dataset, 'F3D')
        titlec = 'Confusion matrix - Florence3D (class-wise recalls)';
        labels = {'Wave', 'Drink', 'Answer phone', 'Clap', 'Tight lace', 'Sit down', 'Stand up', ...
                  'Read watch', 'Bow'};
    elseif strcmpi(dataset, 'UTK')
        titlec = 'Confusion matrix - UTKinect (class-wise recalls)';
        labels = {'Walk', 'Sit down', 'Stand up', 'Pick up', 'Carry', 'Throw', 'Push', 'Pull', ...
                  'Wave hands', 'Clap hands'};
    elseif strcmpi(dataset, 'MSRP')
        titlec = 'Confusion matrix - MSRPairs (class-wise recalls)';
        labels = {'Pick up box', 'Put down box', 'Lift box', 'Place box', 'Push chair', 'Pull chair', ...
                  'Wear hat', 'Take off hat', 'Put on backpack', 'Take off backpack', 'Stick poster', ...
                  'Remove poster'};
    elseif strcmpi(dataset, 'MSRA')
        titlec = 'Confusion matrix - MSRAction3D (class-wise recalls)';
        labels = {'High arm wave', 'Horizontal arm wave', 'Hammer', 'Hand catch', 'Forward punch', ...
                  'High throw', 'Draw x', 'Draw tick', 'Draw circle', 'Hand clap', 'Two handwave', ...
                  'Sideboxing', 'Bend', 'Forward kick', 'Side kick', 'Jogging', 'Tennis swing', ...
                  'Tennis serve', 'Golf swing', 'Pick up and throw'};        
    elseif strcmpi(dataset, 'G3D')
        titlec = 'Confusion matrix - G3D (class-wise recalls)';
        labels = {'Punch right', 'Punch left', 'Kick right', 'Kick left', 'Defend', 'Golf swing', ...
                  'Tennis swing forehand', 'Tennis swing backhand', 'Tennis serve', 'Throw bowling ball', ...
                  'Aim and fire gun', 'Walk', 'Run', 'Jump', 'Climb', 'Crouch', 'Steer a car', 'Wave', ...
                  'Flap', 'Clap'};
    elseif strcmpi(dataset, 'HDM14')
        titlec = 'Confusion matrix - HDM-05-14 (class-wise recalls)';
        labels = {'Clap above head', 'Deposit floor', 'Elbow to knee', 'Grab high', 'Hop both legs', ...
                  'Jog', 'Kick forward', 'Lie down floor', 'Rotate both arms backward', 'Sit down chair', ...
                  'Sneak', 'Squat', 'Stand up lie', 'Throw basketball'};
        labels = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15', ...
                  '16','17','18','19','20','21','22','23','24','25','26','27','28','29'};
    elseif strcmpi(dataset, 'HDM65')
        titlec = 'Confusion matrix - HDM-05-65 (class-wise recalls)';
        labels = {'Cartwheel', 'Clap', 'Clap above head', 'Deposit floor', 'Deposit high', 'Deposit low', ...
                  'Deposit middle', 'Elbow to knee', 'Grab floor', 'Grab high', 'Grab low', 'Grab middle', ...
                  'Hit head', 'Hop both legs', 'Hop on left leg', 'Hop on right leg', 'Jog left circle', ...
                  'Jog on place', 'Jog right circle', 'Jump down', 'Jumping jack', 'Kick left front', ...
                  'Kick left side', 'Kick right front', 'Kick right side', 'Lie down floor', ...
                  'Punch left front', 'Punch left side', 'Punch right front', 'Punch right side', ...
                  'Rotate arms both backward', 'Rotate arms both forward', 'Rotate arm left backward', ...
                  'Rotate arm left forward', 'Rotate arms right backward', 'Rotate arms right forward', ...
                  'Run on place', 'Shuffle', 'Sit down chair', 'Sit down floor', ...
                  'Sit down kneel tie shoes', 'Sit down table', 'Skier', 'Sneak', 'Squat', ...
                  'Staircase down', 'Staircase up', 'Stand up knee', 'Stand up lie floor', ...
                  'Stand up sit chair', 'Stand up sit floor', 'Stand up sit table', 'ThrowBasketball', ...
                  'Throw far', 'Throw sitting high', 'Throw standing high', 'Turn left', 'Turn right', ...
                  'Walk', 'Walk backwards', 'Walk left', 'Walk left circle', 'Walk on place', ...
                  'Walk right circle', 'Walk right cross front'};
    elseif strcmpi(dataset, 'MSRC')
        titlec = 'Confusion matrix - MSRCKinect12 (class-wise recalls)';
        labels = {'Lift outstretched arms', 'Duck', 'Push right', 'Goggles', 'Wind it up', 'Shoot', 'Bow', ...
                  'Throw', 'Had enough', 'Change weapon', 'Beat both', 'Kick'};
    else
        error('Choose the right dataset : F3D, UTK, MSRP, MSRA, G3D, HDM-05-14, HDM-05-65, MSRC.')
    end
    % label plot
    plotclusters(grps, action_label);
    % confusion matrix
    figure(2)
    cm = confusionchart(confusionmat(action_label, grps), labels, 'Title', titlec);
    % Row-normalized results columns: class-wise recalls (or true positive rates)
    % Left column: percentage of correctly-classified observation
    % Right column: percentage of incorrectly-classified observation
    cm.RowSummary = 'row-normalized';
    % visualize affinity matrix W
    figure(3)
    imagesc(W)
    title('Affinity matrix W');
end
