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
    guiVariables = evalin('base', 'guiVariables');
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Compare database
    if (~exist(guiVariables.databasePath, 'dir'))
       status = false;
       return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/LoadedData'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/UnprocessedDataStore.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/ProcessedData'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/ProcessedDataStore.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/AnalysedData'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/AnalysedDataStore.mat'), 'file'))
        % TODO implement when its ready
        %status = false;
        %return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/Experiment'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/ExperimentStore.mat'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/Processers'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/Processers'), 'file'))
        status = false;
        return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/Analysers'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/Analysers.mat'), 'file'))
        % TODO implement when ready
        %status = false;
        %return;
    end
    
    if (~exist(strcat(guiVariables.databasePath, '/Users'), 'dir'))
       status = false;
       return;
    elseif (~exist(strcat(guiVariables.databasePath, ...
            '/LoadedData/UserStore.mat'), 'file'))
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