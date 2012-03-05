%% Parent Function for the Experiment Display Panel's construction

% ========================================================================
%
% Function : buildExperimentDisplay
%
% Description : A GUI function that generates a panel within the core GUI
% to display Experiment Information, it takes information from the thread
% snapshot to generate a relavant panel.
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function [] = buildExperimentDisplay(varargin)
    
    % --------------------------------------------------------------------
    % Handle any callbacks for the buttons/functions that are associated
    % with the user panel
    if (nargin && ischar(varargin{1}))
       feval(varargin{:}); 
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Main thread for panel generation
    if ~nargin
        
        % ----------------------------------------------------------------
        % Setup current GUI for correct display including deleting any
        % childen of the display panels that may have already existed
        threadSnapshot = evalin('base', 'threadSnapshot');
        set(threadSnapshot.handles(2:end), 'Visible', 'off');
        delete(get(threadSnapshot.handles(2), 'Children'));
        delete(get(threadSnapshot.handles(3), 'Children'));
        delete(get(threadSnapshot.handles(4), 'Children'));
        delete(get(threadSnapshot.handles(7), 'Children'));
        set(threadSnapshot.handles(7), 'Visible', 'off');
        delete(get(threadSnapshot.handles(8), 'Children'));
        set(threadSnapshot.handles(8), 'Visible', 'off');
        delete(get(threadSnapshot.handles(21), 'Children'));
        % ----------------------------------------------------------------
        
        
        % ----------------------------------------------------------------
        % Construct the main panel
        buildMainPanel();
        threadSnapshot = evalin('base', 'threadSnapshot');
        Data = threadSnapshot.data;
        Data(:, end + 1) = { false };
        set(threadSnapshot.mainPanelHandles(1), ...
            'ColumnFormat', ...
                { 'char' 'char' 'char' 'char' 'char' 'numeric' 'logical' }, ...
            'ColumnEditable', ...
                [ false false false false false false true ], ...
            'ColumnName', ...
                { 'ExperimentID'; 'Title'; 'Description'; ...
                'Date'; 'User'; 'Batches'; 'Selected' }, ...
            'ColumnWidth', 'auto', ...
            'Data', Data);
        % ----------------------------------------------------------------
        
        % ----------------------------------------------------------------
        % Construct the info panel
        m1 = 'If you wish to edit an existing experiment, please select';
        m2 = ' it from the list below and then press ''Existing''.';
        m3 = ' Otherwise, select ''New'' and add the experiment';
        m4 = ' information.';
        msg = strcat(m1,m2,m3,m4);
        buildInfoPanel(msg, 1, 2);
        % ----------------------------------------------------------------
        
        % ----------------------------------------------------------------
        % Construct the interaction panel
        buildInteractionPanel();
        threadSnapshot = evalin('base', 'threadSnapshot');
        m1 = 'Please select an existing experiment and press ''Existing''';
        m2 = ' or generate a new one by pressing ''New''';
        msg = strcat(m1, m2);
        set(threadSnapshot.interactionPanelHandles(1), ...
            'Position', [0.073 0.265 0.8 0.126506024096386],...
            'String', 'New');
        set(threadSnapshot.interactionPanelHandles(2), ...
            'Position', [0.08 0.09 0.8 0.126506024096386],...
            'String', 'Existing');
        set(threadSnapshot.interactionPanelHandles(3), 'String', msg);
        % ----------------------------------------------------------------
        
        % ----------------------------------------------------------------
        % Display the relevant panels
        set(threadSnapshot.handles([3, 5, 8, 9, 10, 15, 20]), ...
            'Visible', 'on');
        assignin('base', 'threadSnapshot', threadSnapshot);
        % ----------------------------------------------------------------
        
    end
    % --------------------------------------------------------------------
    
end

% ========================================================================
%
% FUNCTION END : buildExperimentDisplay
%
% ========================================================================

%% Layout functions for GUI panels

% ========================================================================
%
% Function : buildMainPanel
%
% Description : Constructs the contents of the main panel for the user
% database display
%
% ========================================================================

function varargout = buildMainPanel () %#ok<STOUT>
    
    threadSnapshot = evalin('base', 'threadSnapshot');
    
    % --------------------------------------------------------------------
    % Component Layout
    h1 = uitable(...
        'Parent', threadSnapshot.handles(3), ...
        'Units', 'normalized', ...
        'Data', ...
            { blanks(0) blanks(0) blanks(0) blanks(0) blanks(0) ...
            blanks(0) blanks(0); blanks(0) blanks(0) blanks(0) ...
            blanks(0) blanks(0) blanks(0) blanks(0) }, ...
        'Position', ...
            [-0.00177304964539007 0.0344827586206897 ...
            0.99822695035461 1], ...
        'Tag', 'experimentDisplayTable', ...
        'CellEditCallback', @(hObject, eventdata)buildExperimentDisplay( ...
            'experimentDisplayTable_Callback', hObject, eventdata, ...
                guidata(hObject)));
    % --------------------------------------------------------------------
            
    threadSnapshot.mainPanelHandles = h1;
    assignin('base', 'threadSnapshot', threadSnapshot);
    
end

% ========================================================================
%
% FUNCTION END : buildMainPanel
%
% ========================================================================

% ========================================================================
%
% Function : buildInteractionPanel
%
% Description : Constructs the contents of the interaction panel for the 
% user database display
%
% ========================================================================

function varargout = buildInteractionPanel ()
    
    threadSnapshot = evalin('base', 'threadSnapshot');
    
    % --------------------------------------------------------------------
    % Component layouts
    h1 = uicontrol(...
        'Parent', threadSnapshot.handles(8), ...
        'Units', 'normalized', ...
        'String', 'New', ...
        'Position', ...
            [0.073 0.265 0.8 0.126506024096386], ...
        'Tag', 'interactButton1', ...
        'Callback', @(hObject, eventdata)buildExperimentDisplay(...
            'interactButton1_Callback', hObject, eventdata, guidata( ...
                hObject)));
            
    h2 = uicontrol(...
        'Parent', threadSnapshot.handles(8), ...
        'Units', 'normalized', ...
        'String', 'Existing', ...
        'Position', ...
            [0.08 0.09 0.8 0.126506024096386], ...
        'Tag', 'interactButton2', ...
        'Callback', @(hObject, eventdata)buildExperimentDisplay(...
            'interactButton2_Callback', hObject, eventdata, guidata( ...
                hObject)));
          
    h3 = uicontrol(...
        'Parent', threadSnapshot.handles(8), ...
        'Units', 'normalized', ...
        'String', 'Static Text', ...
        'Position', ...
            [0.01 0.446 0.99 0.494], ...
        'Tag', 'interactText1', ...
        'Style', 'text');
    % --------------------------------------------------------------------
    
    threadSnapshot.interactionPanelHandles = [h1, h2, h3];
    assignin('base', 'threadSnapshot', threadSnapshot);
    
end

% ========================================================================
%
% FUNCTION END : buildInteractionPanel
%
% ========================================================================

%% Callback functions for the User Display Panel

% ========================================================================
%
% Function : experimentDisplayTable_Callback
%
% Description : Notifies when a selection has been made in the user display
% list
%
% ========================================================================

function experimentDisplayTable_Callback(~,~,~) %#ok<DEFNU>

    % Currently unused
    
end

% ========================================================================
%
% FUNCTION END : userDisplayTable_Callback
%
% ========================================================================

% ========================================================================
%
% Function : interactButton1_Callback
%
% Description : Notifies when a selection has been made in the user display
% list
%
% ========================================================================

function interactButton1_Callback (~,~,~) %#ok<DEFNU>
    
    threadSnapshot = evalin('base', 'threadSnapshot');
    answ = inputdlg('Enter an experiment title', 'Title');
    answ2 = inputdlg('Enter an experiment description', 'Description');
    
    % --------------------------------------------------------------------
    % Check that the experiment is valid, redo on fail
    if (~isempty(answ) && ~isempty(answ2))
        threadSnapshot.experiment = dicomuid;
        threadSnapshot.data = ...
            [{threadSnapshot.experiment}, {answ}, {answ2}, ...
            {date}, {threadSnapshot.user}, {0}];
        assignin('base', 'threadSnapshot', threadSnapshot);
        appendTableToStore('Experiment');
        uiresume;
        delete(get(threadSnapshot.handles(3), 'Children'));
        delete(get(threadSnapshot.handles(7), 'Children'));
        
    elseif (~isempty(answ))
        uiwait(msgbox(...
            'No Title was entered, please try again', ...
            'Warning', ...
            'warn'));
        
    else
        uiwait(msgbox(...
            'No Description was entered, please try again', ...
            'Warning', ...
            'warn'));
        
    end
    % --------------------------------------------------------------------
    
end

% ========================================================================
%
% FUNCTION END : interactButton1_Callback
%
% ========================================================================

% ========================================================================
%
% Function : interactButton2_Callback
%
% Description : Notifies when a selection has been made in the user display
% list
%
% ========================================================================

function interactButton2_Callback(~,~,~) %#ok<DEFNU>
    
    threadSnapshot = evalin('base', 'threadSnapshot');
    panelData = get(threadSnapshot.mainPanelHandles(1), 'Data');
    
    % --------------------------------------------------------------------
    % Check that the user selection is correct and handle accordingly
    % TODO implement a password check
    if (sum([panelData{:,7}]) ~= 1)
        if (sum([panelData{:,7}]) > 1)
            uiwait(msgbox(...
                'Too many experiments were selected, please try again', ...
                'Warning', ...
                'warn'));
        else
            uiwait(msgbox(...
                'No experiment was selected, please try again', ...
                'Warning', ...
                'warn'));
        end
    else
        threadSnapshot.experiment = panelData{logical([panelData{:, 7}]), 1};
        assignin('base', 'threadSnapshot', threadSnapshot);
        uiresume(threadSnapshot.handles(1));
        delete(get(threadSnapshot.handles(3), 'Children'));
        delete(get(threadSnapshot.handles(8), 'Children'));
    end
    % --------------------------------------------------------------------
    
end
% ========================================================================
%
% FUNCTION END : interactButton2_Callback
%
% ========================================================================
