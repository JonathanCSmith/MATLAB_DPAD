%% Parent Function for the User Display Panel's construction

% ========================================================================
%
% Function : buildUserDisplay
%
% Description : A GUI function that generates a panel within the core GUI
% to display User Information, it takes information from the thread
% snapshot to generate a relavant panel.
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function [] = buildUserDisplay(varargin)
    
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
        set(threadSnapshot.handles(2:end), 'visible', 'off');
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
        % Construct the main panel TODO handle password hashes
        buildMainPanel();
        threadSnapshot = evalin('base', 'threadSnapshot');
        Data(:,1) = threadSnapshot.data;
        Data(:,2) = {false};
        set(threadSnapshot.mainPanelHandles(1), ...
            'ColumnFormat', { 'char' 'logical' }, ...
            'ColumnEditable', [ false true ], ...
            'ColumnName', { 'User Name'; 'Selected' }, ...
            'ColumnWidth', 'auto', ...
            'Data', Data);
        % ----------------------------------------------------------------
        
        % ----------------------------------------------------------------
        % Construct the info panel TODO implement this info properly
        m1 = 'For existing users please select your username from the';
        m2 = ' above list and choose the ''existing'' button when you';
        m3 = ' wish to continue, if you are a new user then please select';
        m4 = ' ''new'' to add your username to the the database';
        msg = strcat(m1,m2,m3,m4);
        buildInfoPanel(msg,1,2);
        % ----------------------------------------------------------------
        
        % ----------------------------------------------------------------
        % Construct the interaction panel TODO implement direct setting of
        % text to the buildInteractionPanel function
        buildInteractionPanel();
        threadSnapshot = evalin('base', 'threadSnapshot');
        m1 = 'Please select whether you are a new user or if you are an';
        m2 = ' existing user, if you are an existing user select your';
        m3 = ' username from the list on the right then press';
        m4 = ' ''existing''';
        msg = strcat(m1, m2, m3, m4);
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
        set(threadSnapshot.handles([3,5,7]), 'Visible', 'on');
        assignin('base', 'threadSnapshot', threadSnapshot);
        % ----------------------------------------------------------------
        
    end
    % --------------------------------------------------------------------
    
end

% ========================================================================
%
% FUNCTION END : buildUserDisplay
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
            { blanks(0) blanks(0); blanks(0) blanks(0); ...
              blanks(0) blanks(0); blanks(0) blanks(0) }, ...
        'Position', ...
            [-0.00177304964539007 0.0344827586206897 ...
            0.99822695035461 1], ...
        'Tag', 'userDisplayTable', ...
        'CellEditCallback', @(hObject, eventdata)buildUserDisplay( ...
            'userDisplayTable_Callback', hObject, eventdata, guidata( ...
                hObject)));
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
        'Callback', @(hObject, eventdata)buildUserDisplay(...
            'interactButton1_Callback', hObject, eventdata, guidata( ...
                hObject)));
            
    h2 = uicontrol(...
        'Parent', threadSnapshot.handles(8), ...
        'Units', 'normalized', ...
        'String', 'Existing', ...
        'Position', ...
            [0.08 0.09 0.8 0.126506024096386], ...
        'Tag', 'interactButton2', ...
        'Callback', @(hObject, eventdata)buildUserDisplay(...
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
% Function : userDisplayTable_Callback
%
% Description : Notifies when a selection has been made in the user display
% list
%
% ========================================================================

function userDisplayTable_Callback(~,~,~) %#ok<DEFNU>

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

function interactButton1_Callback () %#ok<DEFNU>
    
    threadSnapshot = evalin('base', 'threadSnapshot');
    answ = inputdlg('Enter your new username', 'Username');
    
    % --------------------------------------------------------------------
    % Check that the username is valid, redo on fail
    % TODO implement a password
    if (~isempty(answ))
       threadSnapshot.user = char(q);
       threadSnapshot.data(end+1, 1) = q;
       assignin('base', 'threadSnapshot', threadSnapshot);
       uiresume;
       delete(get(threadSnapshot.handles(3), 'Children'));
       delete(get(threadSnapshot.handles(7), 'Children'));
    else
        uiwait(msgbox(...
            'No name was entered, please try again', ...
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
    if (sum(panelData{:,2}) ~= 1)
        if (sum(panelData{:,2}) > 1)
            uiwait(msgbox(...
                'Too many users were selected, please try again', ...
                'Warning', ...
                'warn'));
        else
            uiwait(msgbox(...
                'No user was selected, please try again', ...
                'Warning', ...
                'warn'));
        end
    else
        threadSnapshot.user = panelData{logical(panelData{:, 2}), 1};
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