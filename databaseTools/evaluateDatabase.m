% ========================================================================
%
% Function : evaluateDatabase
%
% Description : Main function loop for loading, processing, analysing and
% displying CSynBi's data.
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function status = evaluateDatabase ()

    % --------------------------------------------------------------------
    % Setup initial parameters
    threadSnapshot = evalin('base', 'threadSnapshot');
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Compare database
    if (~exist(threadSnapshot.databasePath, 'dir'))
        status = false;
        return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/LoadedData'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/LoadedData/UnprocessedDataStore.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/ProcessedData'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/ProcessedData/ProcessedDataStore.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/AnalysedData'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/AnalysedData/AnalysedDataStore.mat'), 'file'))
        % TODO implement when its ready
        %status = false;
        %return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/Experiment'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/Experiment/ExperimentStore.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/Processers'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/Processers/Processers.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/Analysers'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/Analysers/Analysers.mat'), 'file'))
        % TODO implement when ready
        %status = false;
        %return;
    end
    
    if (~exist(strcat(threadSnapshot.databasePath, '/Users'), 'dir'))
        status = false;
        return;
    elseif (~exist(strcat(threadSnapshot.databasePath, ...
            '/Users/UserStore.mat'), 'file'))
        status = false;
        return;
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Returns + Workplace setup
    status = true;
    % --------------------------------------------------------------------

end
% ========================================================================
%
% FUNCTION END : evaluateDatabase
%
% ========================================================================