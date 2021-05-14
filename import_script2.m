%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\Kursadmin\Desktop\FlowData\labdata2.txt
%
% Auto-generated by MATLAB on 14-May-2021 09:16:48

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

% Import the data
labdata2 = readtable("labdata2.txt", opts);

%% Convert to output type
labdata2 = table2array(labdata2);

%% Clear temporary variables
clear opts