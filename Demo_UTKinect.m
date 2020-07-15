%% Subspace Clustering for Action Recognition with Covariance Representations and Temporal Pruning
% This demo file contains different temporal pruning strategies [1] and different subspace clustering methods
% [2,3] applied on the UTKinect dataset, with clustering accuracies reported on [1].
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
% [2] Elhamifar, E., & Vidal, R. (2013).
%     Sparse subspace clustering: Algorithm, theory, and applications.
%     IEEE transactions on pattern analysis and machine intelligence, 35(11), 2765-2781.
% [3] Li, S., Li, K., & Fu, Y. (2015).
%     Temporal subspace clustering for human motion segmentation.
%     In Proceedings of the IEEE International Conference on Computer Vision (pp. 4453-4461).

addpath Codes Codes_SSC Codes_TSC Data Ncut; clear all; close all; clc;

disp('Giancarlo Paoletti, Jacopo Cavazza, Cigdem Beyan and Alessio Del Bue (2020).')
disp('Subspace Clustering for Action Recognition with Covariance Representations and Temporal Pruning.')
disp('International Conference on Pattern Recognition (ICPR).')

% select 'true' if you want to plot graphs and confusion matrices
verbose = false;

%% SSC_ADMM applied to the covariance representation from the original dataset, without pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 1/9')
disp('Apply covariance representation on raw skeleton data and find clustering accuracy with SSC_ADMM[2]')
% Load UTKinect dataset
rng(1990); load UTK; tic;
% Apply covariance representation
data = dataCov(data);
% Clustering accuracy with SSC_ADMM[2]
[~, W, grps, accuracy] = evalc('SSC_ADMM(data, action_label, 40, 1, true, false)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% min_phi Temporal pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 2/9')
disp('min_phi Temporal pruning strategy applied to the covariance representation')
% Load UTKinect dataset
clear accuracy action_label data grps W; rng(1990); load UTK; tic;
% Apply the min_phi temporal pruning strategy
data = min_phi(data);
% Apply covariance representation
data = dataCov(data);
% Clustering accuracy with SSC_ADMM[2]
[~, W, grps, accuracy] = evalc('SSC_ADMM(data, action_label, 95, 1, true, true)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% min temporalSSC pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 3/9')
disp('min temporalSSC pruning strategy applied to the covariance representation')
% Load UTKinect dataset
clear accuracy action_label data grps W; rng(1990); load UTK; tic;
% Apply a data augmentation by adding information about velocity and acceleration of movements
data = MovingPose(data);
% Normalize data in range 0~1
data = dataNorm(data);
% Apply the min temporalSSC pruning strategy
[~, data] = evalc('min_temporalSSC(data, 3, 0.73, false, false)');
% Apply covariance representation
data = dataCov(data);
% Clustering accuracy with SSC_ADMM[2]
[~, W, grps, accuracy] = evalc('SSC_ADMM(data, action_label, 58, 1, false, false)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% percentage temporalSSC pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 4/9')
disp('percentage temporalSSC pruning strategy applied to the covariance representation')
% Load UTKinect dataset
clear accuracy action_label data grps W; rng(1990); load UTK; tic;
% Apply the percentage temporalSSC pruning strategy
[~, data] = evalc('percentage_temporalSSC(data, 25, 49, 1, false, false)');
% Prune abnormal samples
[data, action_label] = dataPrune(data, action_label);
% Apply covariance representation
data = dataCov(data);
% Clustering accuracy with SSC_ADMM[2]
[~, W, grps, accuracy] = evalc('SSC_ADMM(data, action_label, 62, 1, true, false)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% threshold temporalSSC pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 5/9')
disp('threshold temporalSSC pruning strategy applied to the covariance representation')
% Load UTKinect dataset
clear accuracy action_label data grps W; rng(1990); load UTK; tic;
% Apply the threshold temporalSSC pruning strategy
[~, data] = evalc('threshold_temporalSSC(data, 75, 80, 1, true, false)');
% Apply covariance representation
data = dataCov(data);
% Clustering accuracy with SSC_ADMM[2]
[~, W, grps, accuracy] = evalc('SSC_ADMM(data, action_label, 80, 1, true, false)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% TSC_ADMM applied to the raw original dataset, using the TSCmin temporal pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 6/9')
disp('TSCmin temporal pruning strategy')
% Load UTKinect dataset
clear accuracy action_label data grps W; rng(1990); load UTK; load UTK_hp; tic;
% Apply the TSCmin temporal pruning strategy
data = min_phi(data);
data = dataFlat(data);
% Clustering accuracy with TSC_ADMM[3]
[~, accuracy, ~, grps, W] = evalc('TSC(data, action_label, hp_min)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% TSC_ADMM applied to the raw original dataset, using the TSCmax temporal pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 7/9')
disp('TSCmax temporal pruning strategy')
% Load UTKinect dataset
clear accuracy action_label data grps hp_km hp_max hp_min hp_sc W; rng(1990); load UTK; load UTK_hp; tic;
% Apply the TSCmax temporal pruning strategy
data = tMax(data);
data = dataFlat(data);
% Clustering accuracy with TSC_ADMM[3]
[~, accuracy, ~, grps, W] = evalc('TSC(data, action_label, hp_max)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% TSC_ADMM applied to the covariance representation, using the temporalSC temporal pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 8/9')
disp('temporalSC temporal pruning strategy, applied on covariance representation of raw skeleton data')
% Load UTKinect dataset
clear accuracy action_label data grps hp_km hp_max hp_min hp_sc W; rng(1990); load UTK; load UTK_hp; tic;
% Apply the temporalSC temporal pruning strategy
data = temporalSC(data);
% Apply covariance representation
data = dataCov(data);
% Clustering accuracy with TSC_ADMM[3]
[~, accuracy, ~, grps, W] = evalc('TSC(data, action_label, hp_sc)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end

%% TSC_ADMM applied to the raw original dataset, using the temporalKm temporal pruning strategy
disp('--------------------------------------------------------------------------------------------------')
disp('UTKinect demo 9/9')
disp('temporalKm temporal pruning strategy')
% Load UTKinect dataset
clear accuracy action_label data grps hp_km hp_max hp_min hp_sc W; rng(1990); load UTK; load UTK_hp; tic;
% Apply the temporalKm temporal pruning strategy
data = temporalKm(data);
data = dataFlat(data);
% Clustering accuracy with TSC_ADMM[3]
[~, accuracy, ~, grps, W] = evalc('TSC(data, action_label, hp_km)');
fprintf('Accuracy: %.2f\n', accuracy); toc;
if verbose
    % Plot the confusion matrix, with the affinity matrix W and the label matchings
    dataPlot(grps, action_label, 'UTK', W)
    disp('Press a key to continue...')
    pause; close all;
end
disp('--------------------------------------------------------------------------------------------------')
