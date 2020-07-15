% dataCov - covariance representation implemented and proposed in [1]
% This function transforms the input data matrix into a covariance matrix; followed by a data normalization,
% data flattening and data concatenation processes.
%
% --- INPUT ---
%  - data : d-by-1 cell-type array dataset; each cell entry is a sample of the given dataset, a 3-by-19-by-T
%           matrix representing the XYZ skeleton joints acquired in T timestamps.
% --- OUTPUT ---
%  - data : d-by-x data matrix of concatenated flattened arrays,
%           computed according to the method developed in [1].
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

function data = dataCov(data)
    dump = data;
    clear data
    for i=1:size(dump,1)
        % Matrix of X/Y/Z values x timestamps (of i-th sample)
        X = squeeze(dump{i,1}(1,:,:));
        Y = squeeze(dump{i,1}(2,:,:));
        Z = squeeze(dump{i,1}(3,:,:));
        % Covariance matrix: computing a COV matrix out of X, Y and Z coordinates
        % of skeleton joints. X, Y and Z must be of dimension J x T, being J the total number of joints
        % and T the total number of timestamps.
        C = cov([X' Y' Z']);
        % Covariance matrix flattening and data normalization in range 0~1.
        % Given a symmetrix matrix C, the flattening process is made by selecting the diagonal and the
        % upper-diagonal part. A dummy variable is used to select which are the indices to select
        % where to cut, followed by the latter application to C.
        data(i,:) = normalize(C(find(triu(ones(size(C)))))', 'range', [0 1]);
    end
end
