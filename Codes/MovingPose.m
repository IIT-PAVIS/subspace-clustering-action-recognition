function data = MovingPose(data)
%     disp('---------------------------------------------')
%     disp('Moving pose in progress...')
    % Build a new data structure (by adding velocity and acceleration) and find the mean of temporal frames
    for i=1:size(data,1)
        temp_data{i,1} = data{i,1};                                                 % X
        temp_data{i,2} = temp_data{i,1}(:,:,2:end) - temp_data{i,1}(:,:,1:end-1);   % V
        temp_data{i,3} = temp_data{i,2}(:,:,2:end) - temp_data{i,2}(:,:,1:end-1);   % A
        n(i) = size(data{i,1},3);
    end
    clear data
    n = round(mean(n));
    % Normalize all temporal frames to be at least equal to T: stretch-duplicate the temporal frames of current sample if they're below T
    while(1)
        upd = 0;
        for i=1:size(temp_data,1)
            if size(temp_data{i,3},3) < n
                temp_data{i,1} = repelem(temp_data{i,1},1,1,2); % X
                temp_data{i,2} = repelem(temp_data{i,2},1,1,2); % V
                temp_data{i,3} = repelem(temp_data{i,3},1,1,2); % A
                upd = upd+1;
            end
        end
        if upd==0
            break
        end
    end
    % Concatenate sample-wise values on temporal-dimension
    for i=1:size(temp_data,1)
        data{i,:} = cat(3, temp_data{i,1}, temp_data{i,2}, temp_data{i,3});
    end
%     disp('Moving pose done.')
end
