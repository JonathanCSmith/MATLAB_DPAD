%% Parent Function for the GUI's construction

% ========================================================================
%
% Function : CSynBi_GUICore
%
% Description : Creates the matlab file database structure that is used
% throughout this program
%
% Author : Jonathan Smith, Imperial College London, Adapted from
% automatically generated GUIDE code
%
% Liscence : LGPL?
%
% ========================================================================

function [] = CSynBi_GUICore (varargin)

    % --------------------------------------------------------------------
    % Generate a GUI setup, calling the layout or callback functions where
    % appropriate
    if (nargin && ischar (varargin{1}))
       feval(str2func(varargin{1})); 
    end
    
    gui_main();
    % --------------------------------------------------------------------

end

% ========================================================================
%
% FUNCTION END : CSynBi_GUICore
%
% ========================================================================

%% Main Function for the GUI's construction

% ========================================================================
%
% Function : gui_main
%
% Description : Lays out the gui for the main CSynBi_LPAD program
%
% ========================================================================

function [] = gui_main ()

    appdata = [];

    % --------------------------------------------------------------------
    % Main parent figure layout
    h1 = figure('Units', 'characters', ...
                'Color', ...
                [0.929411764705882 0.929411764705882 0.929411764705882],...
                'Colormap', ...
                [0 0 0.5625; 0 0 0.625; 0 0 0.6875; ...
                0 0 0.75; 0 0 0.8125; 0 0 0.875; ...
                0 0 0.9375; 0 0 1; 0 0.0625 1; ...
                0 0.125 1; 0 0.1875 1; 0 0.25 1; ...
                0 0.3125 1; 0 0.375 1; 0 0.4375 1; ...
                0 0.5 1; 0 0.5625 1; 0 0.625 1; ...
                0 0.6875 1; 0 0.75 1; 0 0.8125 1; ...
                0 0.875 1; 0 0.9375 1; 0 1 1; ...
                0.0625 1 1; 0.125 1 0.9375; 0.1875 1 0.875; ...
                0.25 1 0.8125; 0.3125 1 0.75; 0.375 1 0.6875; ...
                0.4375 1 0.625; 0.5 1 0.5625; 0.5625 1 0.5; ...
                0.625 1 0.4375; 0.6875 1 0.375; 0.75 1 0.3125; ...
                0.8125 1 0.25; 0.875 1 0.1875; 0.9375 1 0.125; ...
                1 1 0.0625; 1 1 0; 1 0.9375 0; ...
                1 0.875 0; 1 0.8125 0; 1 0.75 0; ...
                1 0.6875 0; 1 0.625 0; 1 0.5625 0; ...
                1 0.5 0; 1 0.4375 0; 1 0.375 0; ...
                1 0.3125 0; 1 0.25 0; 1 0.1875 0; ...
                1 0.125 0; 1 0.0625 0; 1 0 0; ...
                0.9375 0 0; 0.875 0 0; 0.8125 0 0; ...
                0.75 0 0; 0.6875 0 0; 0.625 0 0; ...
                0.5625 0 0],...
                'IntegerHandle', 'off', ...
                'InvertHardcopy', get(0, 'defaultfigureInvertHardcopy'), ...
                'MenuBar','none', ...
                'Name','CSynBi_LPAD', ...
                'NumberTitle','off', ...
                'PaperPosition', get(0, 'defaultfigurePaperPosition'), ...
                'Position', ...
                [103.833333333333 29.1666666666667 112 32.3333333333333], ...
                'HandleVisibility', 'callback', ...
                'UserData', [], ...
                'Tag', 'mainpanel', ...
                'Visible', 'off');
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Graphing panel layout
    h2 = uipanel('Parent', h1, ...
                 'BorderType', 'none', ...
                 'Tag', 'graphingpanel', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [-0.00148809523809524 0.221649484536082 ...
                 0.839285714285714 0.775773195876289]);
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % File display panel layout
    h3 = uipanel('Parent', h1, ...
                 'BorderType', 'none', ...
                 'Tag', 'filedisplaypanel', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [-0.00148809523809524 0.221649484536082 ...
                 0.839285714285714 0.775773195876289]);
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Flow cytometry display panel layout
    h4 = uipanel('Parent', h1, ...
                 'BorderType', 'none', ...
                 'Tag', 'filedisplaypanel', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [-0.00148809523809524 0.221649484536082 ...
                 0.839285714285714 0.775773195876289]);
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % User interact panel layout
    h5 = uipanel('Parent', h1, ...
                 'BorderType', 'none', ...
                 'Tag', 'filedisplaypanel', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [0.834821428571428 -0.00257731958762887 ...
                 0.163690476190476 1]);
             
    % Title panel layout
    h6 = uicontrol('Parent', h5, ...
                   'Units', 'normalized', ...
                   'Position', ...
                   [0.0660377358490566 0.896 ...
                   0.886792452830188 0.106666666666667],...
                   'String', {'Text'}, ...
                   'Style', 'text', ...
                   'Tag', 'titlebox1');
               
    % User edit panel layout
    h7 = uipanel('Parent', h5, ...
                 'BorderType', 'none', ...
                 'Tag', 'editpanel1', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [0.1 0.0212201591511936 ...
                 0.827272727272727 0.40053050397878]);
             
    % Control panel layout
    h8 = uipanel('Parent', h5, ...
                 'BorderType', 'none', ...
                 'Tag', 'controlpanel', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [0.0909090909090909 0.456233421750663 ...
                 0.827272727272727 0.437665782493369]);
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Information panel layout
    h9 = uipanel('Parent', h1, ...
                 'BorderType', 'none', ...
                 'Tag', 'infopanel', ...
                 'Clipping', 'on', ...
                 'Position', ...
                 [-0.00148809523809524 -0.00257731958762887 ...
                 0.840773809523809 0.22680412371134]);
             
    % Axes 1 for image display TODO check this & change tag         
    h10 = axes('Parent', h9, ....
               'Position', ...
               [0.859180035650624 0.12987012987013 ...
               0.121212121212121 0.844155844155844], ...
               'CameraPosition', [0.5 0.5 9.16025403784439],...
               'CameraPositionMode', ...
               get(0, 'defaultaxesCameraPositionMode'), ...
               'Color', get(0, 'defaultaxesColor'), ...
               'ColorOrder', get(0, 'defaultaxesColorOrder'), ...
               'LooseInset', [0.13 0.11 0.095 0.075], ...
               'XColor', get(0, 'defaultaxesXColor'), ...
               'YColor', get(0, 'defaultaxesYColor'), ...
               'ZColor', get(0, 'defaultaxesZColor'), ...
               'Tag', 'imageaxes1');
           
    % Axis 1 properties, undefined because this axes is for image display
    h11 = get(h10, 'title');
    h12 = get(h10, 'xlabel');
    h13 = get(h10, 'ylabel');
    h14 = get(h10, 'zlabel');
    
    % Axes 2 for image display TODO as above
    h15 = axes('Parent', h9, ...
               'Position', ....
               [0.656637168141593 0.12987012987013 ...
               0.191150442477876 0.844155844155844],...
               'CameraPosition', [0.5 0.5 9.16025403784439], ...
               'CameraPositionMode', ...
               get(0, 'defaultaxesCameraPositionMode'), ...
               'Color', get(0, 'defaultaxesColor'), ...
               'ColorOrder', get(0, 'defaultaxesColorOrder'), ...
               'LooseInset', ...
               [0.129015151515152 0.106071428571429 ...
               0.094280303030303 0.0723214285714286],...
               'XColor', get(0,'defaultaxesXColor'), ...
               'YColor', get(0, 'defaultaxesYColor'), ...
               'ZColor', get(0, 'defaultaxesZColor'), ...
               'Tag', 'imageaxes2');
           
    % Axes 2 properties, undefined because this axes is for image display
    h16 = get(h15, 'title');
    h17 = get(h15, 'xlabel');
    h18 = get(h15, 'ylabel');
    h19 = get(h15, 'zlabel');
             
    % Description panel layout
    h20 = uicontrol('Parent', h9, ...
                   'Units', 'normalized', ...
                   'Position', ...
                   [-0.0017825311942959 0.164383561643836 ...
                   0.64349376114082 0.835616438356165], ...
                   'String', {'Text'}, ...
                   'Style', 'text', ...
                   'Tag', 'descriptionbox1');
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Main display layout - other layout managers use this to display
    % specific layout types
    h21 = uipanel('Parent', h1, ...
                  'BorderType', 'none', ...
                  'Tag', 'mainpanel', ...
                  'Clipping', 'on', ...
                  'Position', ...
                  [-0.00148809523809524 0.221649484536082 ...
                  0.839285714285714 0.775773195876289], ...
                  'ResizeFcn', @(hObject,eventdata)Jon_MainGUI(...
                    'DisplayPanels_ResizeFcn',hObject,eventdata,appdata));
    
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Change GUI settings and setup returns
    
    % Remove ticks on axes for clean image display
    set(h10, 'XTick', [], 'YTick', []);
    set(h15, 'XTick', [], 'YTick', []);
    
    % Visibility setup
    set(h1, 'Visible', 'off');
    
    % Setup handles structure so all components can be accessed later.
    threadSnapshot = struct('handles', [h1,h2,h3,h4,h5,h6,h7,h8,h9,h10, ...
                            h11,h12,h13,h14,h15,h16,h17,h18,h19,h20, ...
                            h21], ...
                          'databasePath', 'NULL');
    assignin('base','threadSnapshot',threadSnapshot);
    
    % --------------------------------------------------------------------

end

% ========================================================================
%
% FUNCTION END : gui_main
%
% ========================================================================

%% Callback Functions for the GUI's components

% ========================================================================
%
% Function : DisplayPanels_ResizeFcn
%
% Description : Resizes the main CSynBi_LPAD program
%
% ========================================================================

function DisplayPanels_ResizeFcn(~,~,~) %#ok<DEFNU>

    % --------------------------------------------------------------------
    % Check that it has been constructed first
    if evalin('base','exist(''threadSnapshot'',''var'');') == 1

        % -----------------------------------------------------------------
        % Variable setup
        threadSnapshot = evalin('base', 'threadSnapshot');
        figureposition = get(threadSnapshot.handles(1), 'Position');
        interactposition = get(threadSnapshot.handles(5), 'Position');
        newinteractposition = interactposition;
        infoposition = get(threadSnapshot.handles(9), 'Position');
        newinfoposition = infoposition;
        axes1position = get(threadSnapshot.handles(10), 'Position');
        newaxes1position = axes1position;
        axes2position = get(threadSnapshot.handles(15), 'Position');
        newaxes2position = axes2position;
        panelposition = get(threadSnapshot.handles(2), 'Position');
        textposition = get(threadSnapshot.handles(20), 'Position');
        newtextposition = textposition;
        % -----------------------------------------------------------------

        % -----------------------------------------------------------------
        % Interact panel resize
        if interactposition(3) * figureposition(3) ~= 25
            newinteractposition(3) = 25 / figureposition(3);
            newinteractposition(1) = 1 - newinteractposition(3);
            set(threadSnapshot.handles(5), 'Position', newinteractposition);
        end
        % -----------------------------------------------------------------

        % -----------------------------------------------------------------
        % Info panel resize
        if infoposition(4) * figureposition(4) ~= 8
           newinfoposition(4) = 8 / figureposition(4); 
           newinfoposition(3) = newinteractposition(1);
           set(threadSnapshot.handles(9), 'Position', newinfoposition);

           % Max width on images
           newaxes1position(3) = (11.5 / newinfoposition(3)) ...
                                    / figureposition(3);
           newaxes1position(1) = 1 - newaxes1position(3);
           newaxes2position(3) = (17 / newinfoposition(3))...
                                    / figureposition(3);
           newaxes2position(1) = (1 - newaxes1position(3)) - ...
               ((17.5 / newinfoposition(3)) ...
                    /figureposition(3));
           set(threadSnapshot.handles(10), 'Position', newaxes1position);
           set(threadSnapshot.handles(15), 'Position', newaxes2position);

           % Text width
           newtextposition(3) = newaxes2position(1);
           set(threadSnapshot.handles(20), 'Position', newtextposition);

        end
        % -----------------------------------------------------------------

        % -----------------------------------------------------------------
        % Main panel resize
        if panelposition(2) ~= newinfoposition(4) || ...
                panelposition(4) ~= 1 - newinfoposition(4) || ...
                panelposition(1) ~= 0 || ...
                panelposition(3) ~= 1 - newinteractposition(3)
           newpanelposition(1) = 0;
           newpanelposition(2) = newinfoposition(4);
           newpanelposition(3) = 1 - newinteractposition(3);
           newpanelposition(4) = 1 - newinfoposition(4) - figureposition(4)/3000;
           set(threadSnapshot.handles([2,3,4,21]),'Position',newpanelposition);
        end
        % -----------------------------------------------------------------
        
    end
    % --------------------------------------------------------------------
    
end

% ========================================================================
%
% FUNCTION END : DisplayPanels_ResizeFcn
%
% ========================================================================

