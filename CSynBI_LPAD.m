% ========================================================================
%
% Function : CSynBI_LPAD
%
% Description : Main function loop for loading, processing, analysing and
% displying CSynBI's data.
%
% Author: Jonathan Smith, Imperial College London
%
% Liscence: LGPL?
%
% ========================================================================

function [] = CSynBI_LPAD (debug)

    % --------------------------------------------------------------------
    % Setup the initial paramaters for the workspace
    if (debug == false)
        close all hidden;
        clear all hidden;
        clc;
    end
    database = false;
    
    % Ensure the environment will load all of the files required
    runtimePath = pwd;
    addpath(genpath(runtimePath));
    
    % Core GUI setup, see mfile for details
    CSynBI_GUICore(); % TODO
    
    % Runtime event pager and data store
    guiVariables = evalin('base', 'guiVariables'); 
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % TODO Environment setup checks from CSynBI_GUICore
    %
    % Not sure if this is necessary at the moment, it is just here as a
    % placeholder
    %
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Database loading, calls generator if it is a new database
    while (~database)
        
        % Handles a new database scenario
        msg = 'Do you have an existing MATLAB database?';
        answ = questdlg(msg,'New Database?');
        switch answ
            case 'Yes'
                
                % --------------------------------------------------------
                % Get database location and validation followed
                % by runtime variable update
                m1 = 'Please locate the folder in which your database is';
                m2 = ' located.';
                msg = strcat(m1,m2);
                uiwait(msgbox(msg, 'Database Location', 'help'));
                
                answ = uigetdir();
                if (answ == 0)
                   % TODO user inform on invalid database location
                   return
                else 
                    guiVariables.databasePath = answ;
                    assignin('base', 'guiVariables', guiVariables);
                    answ = evaluateDatabase();
                    if (answ)
                        database = true;
                    else
                       % TODO implement a user inform here - corrupt file
                       % structure
                       return;
                    end
                end
                % --------------------------------------------------------
                
            case 'No'
                
                % --------------------------------------------------------
                % Generate database with preset structure and update local
                % runtime variables
                generateDatabase(); % TODO full generation and loading 
                guiVariables = evalin('base', 'guiVariables');
                if (strcmp(guiVariables.databasePath,'NULL')) 
                    % TODO implement a user inform here - something went 
                    % wrong
                    return;
                else
                    database = true;
                end
                % --------------------------------------------------------
                
            case 'Cancel'
                
                % TODO implement a user inform here
                return;
                
        end
    end
    % --------------------------------------------------------------------
    
    % TODO EXPERIMENT LOADING SCREEN!!!! Loadings are batch, may also need
    % to have a batch database
end
% ========================================================================
%
% FUNCTION END: CSynBI_LPAD
%
% ========================================================================