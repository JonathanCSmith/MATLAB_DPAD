% ========================================================================
%
% Function : generateDatabase
%
% Description : Creates the matlab file database structure that is used
% throughout this program
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function [] = generateDatabase()

    % --------------------------------------------------------------------
    % Setup initial parameters
    threadSnapshot = evalin('base','threadSnapshot');
    m1 = 'Please located the desired directory for the database to be';
    m2 = ' created';
    uiwait(msgbox(strcat(m1,m2), 'Database Location', 'help'));
    answ = uigetdir();
    
    if (answ == 0)
        threadSnapshot.databasePath = 'NULL';
        return;
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Setup file structure
    databaseRoot = strcat(threadSnapshot.databasePath,'/CSynBi_Database');
    mkdir(databaseRoot);
    mkdir(strcat(databaseRoot,'/LoadedData'));
    mkdir(strcat(databaseRoot,'/ProcessedData'));
    mkdir(strcat(databaseRoot,'/AnalysedData'));
    mkdir(strcat(databaseRoot,'/Experiment'));
    mkdir(strcat(databaseRoot,'/Processers'));
    mkdir(strcat(databaseRoot,'/Analysers'));
    mkdir(strcat(databaseRoot,'/Users'));
    threadSnapshot.databasePath = databaseRoot;
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Setup matlab file structure
    
    %#ok<*NASGU> % Don't listen to matlab - it lies!
    
    % Unprocessed data store contains all of the raw loaded files, the only
    % information that should be correlated here is experiment within the
    % metadata, all other information should then be preserved in the
    % experiment dataset. Data can be three dimensional.
    UnprocessedDataStore = struct('SampleID', 0, ...
                                     'Data', {' '}, ...
                                     'Metadata', {' '}); 
    save(strcat(databaseRoot,'/LoadedData/UnprocessedDataStore.mat'), ...
        'UnprocessedDataStore');
    
    % Processed data store contains all of the datasets that have been
    % associated with a single experiment, this is usually also delineated
    % by the source of the data and recombined later at the analysis stage
    % (i.e. the sum total of the data should a group of associated samples
    % over time under specific conditions).
    tempLayout = struct('Mean', 0, 'Median', 0, 'Mode', 0);
    ProcessedDataStore = ...
        struct('SampleID', 0,...
               'Data', struct('Values', tempLayout, ...
                              'Times', tempLayout, ...
                              'Statistics', tempLayout, ...
                              'TimeStatistics', tempLayout), ...
               'Metadata', struct('UnprocessedDataStoreIDs', {'0'}, ...
                                  'SourceInformation', {'0'}, ...
                                  'ProcessingInformation', {'0'}, ...
                                  'DatasetSummary', {'0'}));
    save(strcat(databaseRoot,'/ProcessedData/ProcessedDataStore.mat'), ...
        'ProcessedDataStore');
    
    % User database as this allows quick searching of data sets, resuming
    % of data analysis and database maintenance priviliges
    UsersStore = struct('UserID',0,'Username','Root','Password:','none');
    % TODO p file for user storage of password hash maps
    save(strcat(databaseRoot,'/Users/UserStore.mat','UserStore'));
    
    % Analysed data store, currently un-implemented
    AnalysedDataStore = null;
    % TODO implement and save
    
    % Experiment data store groups the data being loaded by session under
    % the assumption that these represent all of the data within a single
    % experiment. This can be refined to allow the user to load data for a
    % different experiment.
    ExperimentStore = struct('ExperimentID', 0, ...
                             'Title', 'Template', ....
                             'Description', 'This is a template', ...
                             'Date', date, ...
                             'User', 0, ...
                             'Batches', struct('BatchID', 0, ...
                                               'DateTimeAdded', clock, ...
                                               'UnprocessedFiles', {0}, ...
                                               'ProcessedFiles', {0}, ...
                                               'AnalysedFiles', 'None', ...
                                               'Relationships', 0));
    save(strcat(databaseRoot,'/Experiments/ExperimentStore.mat', ...
        'ExperimentStore'));
    
    % Processers are a qualitative description of how the
    % original files have been processed to arrive at the values observed
    % in ProcessedDataStore
    Processers = struct('ProcessID', 0, ...
                        'Title', 0, ...
                        'Description', 0, ...
                        'ManipulationType', 0, ...
                        'Protocol', 0, ...
                        'IdentitiesDiscovered', 0);
    save(strcat(databaseRoot,'/Processers/Processers.mat','Processers'));
    
    % Analysers are a qualitative description of how the processed data
    % sets have been processed to arrive at analysed data, these are not
    % yet grouped according to publishable displays but are no longer
    % limited to single data type parameters.
    Analysers = null;
    % TODO implement and save
                                    
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Finish Up!
    assignin('base', 'threadSnapshot', threadSnapshot);
    % --------------------------------------------------------------------


end

% ========================================================================
%
% FUNCTION END : generateDatabase
%
% ========================================================================