% ========================================================================
%
% Function : CSynBi_LPAD
%
% Description : Main function loop for loading, processing, analysing and
% displying CSynBi's data.
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function [] = CSynBi_LPAD (debug)

    % TODO implement a loop so that multiple experiments can be loaded

    % --------------------------------------------------------------------
    % Setup the initial paramaters for the workspace
    if (~exist('session','var'))
        if (debug == false)
            close all hidden;
            clear all hidden;
            clc;
        end
        session = true;
        database = false;

        % Ensure the environment will load all of the files required
        runtimePath = pwd;
        addpath(genpath(runtimePath));

        % Core GUI setup, see mfile for details
        CSynBi_GUICore(); % TODO

        % Runtime event pager and data store
        threadSnapshot = evalin('base', 'threadSnapshot');
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Check that the GUI setup correctly
    if (~isfield(threadSnapshot, 'handles') && ...
            size(threadSnapshot.handles,2) ~= 21)
        % TODO implement a user inform of badly formed GUI / Session
        return;
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Database loading, calls generator if it is a new database
    if (~strcmp(threadSnapshot.databasePath,'NULL'))
        if (evaluateDatabase)
            database = true;
        end
    end
    
    % While loop for generating a correct database // might be unnecessary
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
                    threadSnapshot.databasePath = strcat(...
                                                answ,'/CSynBi_Database');
                    assignin('base', 'threadSnapshot', threadSnapshot);
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
                threadSnapshot = evalin('base', 'threadSnapshot');
                if (strcmp(threadSnapshot.databasePath,'NULL')) 
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
    
    % --------------------------------------------------------------------
    % Setup a user environment
    
    data = load(strcat(threadSnapshot.databasePath, ...
        '/Users/UserStore.mat'), 'UserStore');
    threadSnapshot.data = data.UserStore;
    assignin('base', 'threadSnapshot', threadSnapshot);
    parseStoreToTable();
    threadSnapshot = evalin('base', 'threadSnapshot');
    
    % Handles if a user is already logged in, this is for future looping of
    % the main function to handle multiple experiment loading
    if (isfield(threadSnapshot, 'user') && ...
            ~strcmp(threadSnapshot.user, 'NULL'))
        
        msg = 'Do you want to use your current username?';
        answ = questdlg(msg, 'User');
        switch answ
            case 'Yes'
                skip = true;
                
            case 'No'
                skip = false;
                
            case 'Cancel'
                % TODO user inform on cancel press
                return;
        end  
    else
        skip = false;
    end
    
    % This loop displays a list of known users or can add a new user, TODO
    % password implementation
    if (~skip)
        assignin('base', 'threadSnapshot', threadSnapshot);
        buildUserDisplay();
        set(threadSnapshot.handles(1), 'Visible', 'on');
        uiwait(threadSnapshot.handles(1));
        threadSnapshot = evalin('base', 'threadSnapshot');
        
        % ----------------------------------------------------------------
        % Check to see that it was all set up correctly & save for new
        % users
        if (~isfield(threadSnapshot, 'user') || ...
                strcmp(threadSnapshot.user,'NULL'))
            % TODO implement a user inform that the user system failed
            return;
        end
        % ----------------------------------------------------------------
        
    else
        set(threadSnapshot.handles(1), 'Visible', 'on');
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Setup an experiment environment for tracking associated information
    
    skip = false;
    data = load(strcat(threadSnapshot.databasePath, ...
        '/Experiment/ExperimentStore.mat'), 'ExperimentStore');
    threadSnapshot.data = data.ExperimentStore;
    assignin('base', 'threadSnapshot', threadSnapshot);
    parseStoreToTable();
    threadSnapshot = evalin('base', 'threadSnapshot');
    
    % Handle the unusual/unlikely case where the user is still editing an
    % experiment profile
    if (isfield(threadSnapshot, 'experiment') && ...
            ~strcmp(threadSnapshot.experiment, 'NULL'))
        
        msg = 'Do you want to continue editing the current experiment?';
        answ = questdlg(msg, 'Experiment Information');
        switch answ
            case 'Yes'
                skip = true;
                
            case 'No'
                skip = false;
                
            case 'Cancel'
                % TODO implement a user inform for cancel press
                return;
        end
    else
        skip = false;
    end
    
    % Handle generating a new experiment profile and recording it to the
    % current thread snapshot and updating the database
    if (~skip)
        assignin('base', 'threadSnapshot', threadSnapshot);
        buildExperimentDisplay();
        set(threadSnapshot.handles(1), 'Visible', 'on');
        uiwait(threadSnapshot.handles(1));
        threadSnapshot = evalin('base', 'threadSnapshot');
        
        % ----------------------------------------------------------------
        % Check to see that everything was setup correctly and save it to
        % the disk
        if (~isfield(threadSnapshot, 'experiment') || ...
                strcmp(threadSnapshot.experiment,'NULL'))
            % TODO implement a user inform that the user system failed
            return;
        end
        % ----------------------------------------------------------------
    end
    
    % TODO EXPERIMENT LOADING SCREEN!!!! Loadings are batch, may also need
    % to have a batch database
    
    % --------------------------------------------------------------------
    
    % TODO Experiment handling in main thread loop, I may be able to use
    % the previous as a handler...
end
% ========================================================================
%
% FUNCTION END : CSynBi_LPAD
%
% ========================================================================