function [accuracy, err, grps, W] = TSC(data, action_label, final_parameters)
    X = Normalize(data');
    % Representation matrix Z
    [~,Z,err] = TSC_ADMM(X,final_parameters);
    % Graph construction and segmentation
    nbCluster = length(unique(action_label));
    vecNorm = sum(Z.^2);
    W = (Z'*Z) ./ (vecNorm'*vecNorm + 1e-6);
    [oscclusters,~,~] = ncutW(W,nbCluster);
    grps = denseSeg(oscclusters, 1);
    grps = bestMap(action_label, grps);
    accuracy = compacc(grps, action_label)*100;
end
