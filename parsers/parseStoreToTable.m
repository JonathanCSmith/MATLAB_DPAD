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

function [] = parseStoreToTable ()

    threadSnapshot = evalin('base', 'threadSnapshot');
    DataIn = threadSnapshot.data;
    
    % --------------------------------------------------------------------
    % Deal with sub structures TODO implement sub sub structs if required
    fields = fieldnames(DataIn);
    s1 = size(fields,1);
    loc = [];
    test = false;
    for (i = 1 : s1)
       if isstruct(DataIn(1).(fields{i}))
           loc = [loc, i];
           test = true;
%            temp = DataIn.(fields{i});
%            s2 = size(DataIn.(fields{i}), 1);
%            DataIn.(fields{i}) = s2;
       end
    end
    
    if (test == true)
        for (i = 1 : size(DataIn, 1))
            for (j = 1 : size(loc, 2))
               DataIn(i).(fields{loc(j)}) = size(DataIn(i).(fields{j}), 1);
            end
        end
    end
    % --------------------------------------------------------------------
    
    % --------------------------------------------------------------------
    % Apply permutations
    DataOut = struct2cell(DataIn);
    DataOut = permute(DataOut, [2, 1, 3]);
    % --------------------------------------------------------------------
    
    threadSnapshot.data = DataOut;
    assignin('base', 'threadSnapshot', threadSnapshot);

end

% ========================================================================
%
% FUNCTION END : parseExperimentStoreToTable
%
% ========================================================================