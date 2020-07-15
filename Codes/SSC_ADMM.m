function [W, grps, accuracy] = SSC_ADMM(data, action_label, alpha, rho, affine, outlier)
    if (~outlier)
        CMat = admmLasso_mat_func(data',affine,alpha);
        C = CMat;
    else
        CMat = admmOutlier_mat_func(data',affine,alpha);
        N = size(data',2);
        C = CMat(1:N,:);
    end
    W = BuildAdjacency(thrC(C,rho));
    grps = SpectralClustering(W,max(action_label));
    grps = bestMap(action_label,grps);
    missrate = sum(action_label(:) ~= grps(:)) / length(action_label);
    accuracy = (1 - missrate) * 100;
end
