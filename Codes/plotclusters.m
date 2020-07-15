function plotclusters(predicted_labels,true_labels)

    if (size(predicted_labels,1) > size(predicted_labels,2))
        predicted_labels = predicted_labels';
    end
    if (size(true_labels,1) > size(true_labels,2))
        true_labels = true_labels';
    end
    
    screensize = get(0,'ScreenSize');
    figure('position',[100,screensize(4)/2,800,150]);
    sgtitle('Label comparison');
    h = axes;
    set(h,'position',[0,0.2,0.987,1.8]);
    
    subplot(2,1,1)
    imagesc(true_labels)
    title('true labels')
    set(gca,'XTick',[]);
    set(gca,'YTick',[]);
    
    subplot(2,1,2)
    imagesc(predicted_labels);
    title('predicted labels')
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    
end
