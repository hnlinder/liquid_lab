%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: labdata.txt
%
% Auto-generated by MATLAB on 14-May-2021 08:53:50

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["VarName1", "VarName2"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["VarName1", "VarName2"], "ThousandsSeparator", ",");

% Import the data
labdata = readtable("labdata.txt", opts);

%% Convert to output type
labdata = table2array(labdata);

%% Clear temporary variables
clear opts