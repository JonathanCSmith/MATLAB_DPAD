% ========================================================================
%
% Function : parseExperimentStoreToTable
%
% Description : changes the structure storage to a flatfile type storage
% for display
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function [] = appendTableToStore (destination)

    %#ok<*NASGU> Matlab Lies!
    threadSnapshot = evalin('base', 'threadSnapshot');
    DataIn = threadSnapshot.data;
    
    % --------------------------------------------------------------------
    % Append data to relevant store
    switch destination
        case 'User'
            UserStore = load(strcat(threadSnapshot.databasePath, ...
                '/Users/UserStore.mat'), 'UserStore');
            UserStore = UserStore.UserStore;
            s1 = size(UserStore, 1);
            newStruct = struct('UserID', DataIn{1}, ...
                               'Username', DataIn{2}, ...
                               'Password', 'none');
            UserStore(s1 + 1, 1) = newStruct;
            save(strcat(threadSnapshot.databasePath, ...
                '/Users/UserStore.mat'), 'UserStore');
        
        case 'Experiment'
            ExperimentStore = load(strcat(threadSnapshot.databasePath, ...
                '/Experiment/ExperimentStore.mat'), 'ExperimentStore');
            ExperimentStore = ExperimentStore.ExperimentStore;
            s1 = size(ExperimentStore, 1);
            newStruct = struct('ExperimentID', DataIn{1}, ...
                              'Title', DataIn{2}, ....
                              'Description', DataIn{3}, ...
                              'Date', DataIn{4}, ...
                              'User', DataIn{5}, ...
                              'Batches', struct('BatchID', 0, ...
                                                'DateTimeAdded', clock, ...
                                                'UnprocessedFiles', {0}, ...
                                                'ProcessedFiles', {0}, ...
                                                'AnalysedFiles', 'None', ...
                                                'Relationships', 0));
            
            ExperimentStore(s1 + 1, 1) = newStruct; 
            save(strcat(threadSnapshot.databasePath, ...
                '/Experiment/ExperimentStore.mat'), 'ExperimentStore'); 
    end
    % --------------------------------------------------------------------

    assignin('base', 'threadSnapshot', threadSnapshot);
    
end

% ========================================================================
%
% FUNCTION END : parseExperimentStoreToTable
%
% ========================================================================