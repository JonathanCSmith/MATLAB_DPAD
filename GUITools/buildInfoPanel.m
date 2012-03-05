% ========================================================================
%
% Function : buildInfoPanel
%
% Description : A GUI function that generates an information panel for the
% core GUI, this is separated so that it can pre-load images and not have
% to reload them every time the display is altered
%
% Author : Jonathan Smith, Imperial College London
%
% Liscence : LGPL?
%
% ========================================================================

function [] = buildInfoPanel (String, State1, State2)
    
    threadSnapshot = evalin('base', 'threadSnapshot');
    set(threadSnapshot.handles(20), 'String', String);
    
    % --------------------------------------------------------------------
    % Generate signleton instance of the panel so that it is never
    % re-created
    persistent Current
    
    % First time setup
    if (isempty(Current))
        Current = [State1, State2];
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Change the images by comparing desired to actual states
    
    % Change first image placeholder
    if (Current(1) ~= State1)
        switch State1
            case 1
                im = imread(strcat(pwd, '/Resources/logo.png'));
                image(im, 'Parent', threadSnapshot.handles(15));
                Current(1) = State1;
                
            case 2
                Current(1) = State1;
        end
    end
    
    % Change second image placeholder
    if (Current(2) ~= State2)
        switch State2
            case 1
                im = imread(strcat(pwd, '/Resources/warning.png'));
                image(im, 'Parent', threadSnapshot.handles(10));
                Current(2) = State2;
                
            case 2
                im = imread(strcat(pwd, '/Resources/help.png'));
                image(im, 'Parent', threadSnapshot.handles(10));
                Current(2) = State2;
        end
    end
    % --------------------------------------------------------------------
    
end

% ========================================================================
%
% FUNCTION END : buildInfoPanel
%
% ========================================================================