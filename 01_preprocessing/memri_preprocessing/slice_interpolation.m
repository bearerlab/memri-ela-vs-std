%%% Slice_Fix.m %%%
% Summary: This script fixes RF feedthrough slice artifacts/glitches in NIfTI MR images.
% Slices are linearly interpolated from good quality surrounding slices.  
% Caution should be used for 2+ contiguous slices with slice artifacts.
%
% This function requires user input for file selection and 
% for identification of slices in coronal plane that need to be replaced.
% Currently, only the slices in y-dimenion. 
% For us, slices are interpolated along anterior-posterior dimension between coronal slices
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % NOTE: Voxel resolution/size must be hard-coded below on line 78. %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Version #:
% v0 - 1/10/2024 - Taylor W. Uselman, University of New Mexico
%% CCC
clear;
close all;
clc;
%% Load NIfTI file
[fname,pathname]= uigetfile('*.nii', 'Load NIfTI Image','MultiSelect', 'off');
    if isequal(fname,0)
        fprintf('You must select a NIfTI file\n');
        return;
    end
    ffname = strcat(pathname,fname);
sz=size(ffname);
nii = niftiread(ffname);
info = niftiinfo(ffname);
%% User input for Slices to Fix and Algorithms
p0 = inputdlg('Are there multiple non-adjacent slices that need to be fixed...','Prompt',1,{'No'});
if p0 == "Yes" || p0 == "yes" || p0 == "Y" || p0 == "y"
    cnt_slice = inputdlg('How many different non-adjacent sections needed?','Prompt',1,{'2'});
    cnt_slice = str2double(cnt_slice{1});
else
    cnt_slice = 1;
end
cnt=0;
nii_new = nii;
sznii = size(nii_new);
% Slice Fixing Algorithms
while cnt < cnt_slice
    cnt=cnt+1;
    p1 = questdlg('How many contiguous slices have RF-feedthrough?', ...
        'Slice Glitch Type', ...
        '1 Slice','2+ Slices','1 Slice');
    if p1 == "1 Slice"
        slicenum = inputdlg('What is the slice that needs to be fixed?','Prompt',1,{'85'});
        slicenum = str2double(slicenum{1});
        slicenum_1 = slicenum;
        slicenum_2 = slicenum;
    elseif p1 == "2+ Slices"
        fprintf("Caution: For 2+ contiguous slices, be sure to assess quality of output.\n"); 
        slicenum_1 = inputdlg('Enter the first slice of range...','Prompt',1,{'85'});
        slicenum_1 = str2double(slicenum_1{1});
        slicenum_2 = inputdlg('Enter the last slice of range...','Prompt',1,{'87'});
        slicenum_2 = str2double(slicenum_2{1});
    else
        break
    end
    s1=slicenum_1 - 1;
    s2=slicenum_2 + 1;
    cnt2=0;
    % Linear interpolation between coronal slices
    for n = slicenum_1:slicenum_2
        nii_new(:,slicenum_1+cnt2,:) = nii(:,slicenum_1,:) + ...
        ((n-s1)/(s2-s1))*(nii(:,slicenum_2,:)-nii(:,slicenum_1,:));
        cnt2=cnt2+1;
    end
end
%% Write New NIfTI file
fname2=strcat(ffname(1:(sz(2)-4)),"_sliced.nii");
[ofname,opathname] = uiputfile(fname2);
offname = strcat(opathname,ofname);
Nh = info;
Nh.ImageSize = size(nii_new);
Nh.PixelDimensions = [0.1,0.1,0.1];
Nh.Datatype = 'int16';
b=cast(nii_new,Nh.Datatype);
Nh.BitsPerPixel = 16;
Nh.Description = 'Slice Artifact Interpolated NIFTI-1 file';
niftiwrite(b,offname,Nh);
%% CCC
clear;
close all;
clc;