clear matlabbatch
spm('defaults','fMRI');
spm_jobman('initcfg');

% Directories and files
base_dir = fileparts(mfilename('fullpath'));
sub_dir = fullfile(base_dir, 'sub-M03953');

% Unzip functional file if zipped
func_zip = dir(fullfile(sub_dir, 'func', '*.nii.gz'));
if ~isempty(func_zip)
    disp(['Found ' num2str(length(func_zip)) ' compressed .nii.gz file(s). Uncompressing...']);
    
    for i = 1:length(func_zip)
        zip_path = fullfile(func_zip(i).folder, func_zip(i).name);

        gunzip(zip_path);

        fprintf('Unzipped: %s\n', func_zip(i).name);
    end
else
    disp('No .nii.gz files found in the directory.');
end

input_func = spm_select('FPList', fullfile(sub_dir,'func'), '^sub-.*bold\.nii$');
input_anat = spm_select('FPList', fullfile(sub_dir,'anat'), '^sub-.*T1w\.nii$');
spm_dir = fileparts(which('spm'));

% Preprocessing
matlabbatch{1}.spm.spatial.realign.estwrite.data = {cellstr(input_func)};
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.95;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 1.5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
matlabbatch{2}.spm.temporal.st.scans{1}(1) = cfg_dep('Realign: Estimate & Reslice: Resliced Images (Sess 1)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','sess', '()',{1}, '.','rfiles'));
matlabbatch{2}.spm.temporal.st.nslices = 24;
matlabbatch{2}.spm.temporal.st.tr = 2;
matlabbatch{2}.spm.temporal.st.ta = 1.91666666666667;
matlabbatch{2}.spm.temporal.st.so = [24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1];
matlabbatch{2}.spm.temporal.st.refslice = 12;
matlabbatch{2}.spm.temporal.st.prefix = 'a';
matlabbatch{3}.spm.spatial.coreg.estimate.ref(1) = cfg_dep('Realign: Estimate & Reslice: Mean Image', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rmean'));
matlabbatch{3}.spm.spatial.coreg.estimate.source = cellstr(input_anat);
matlabbatch{3}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
matlabbatch{4}.spm.spatial.preproc.channel.vols(1) = cfg_dep('Coregister: Estimate: Coregistered Images', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','cfiles'));
matlabbatch{4}.spm.spatial.preproc.channel.biasreg = 0.0001;
matlabbatch{4}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{4}.spm.spatial.preproc.channel.write = [0 1];
matlabbatch{4}.spm.spatial.preproc.tissue(1).tpm = cellstr([spm_dir '/tpm/TPM.nii,1']);
matlabbatch{4}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{4}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(2).tpm = cellstr([spm_dir '/tpm/TPM.nii,2']);
matlabbatch{4}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{4}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(3).tpm = cellstr([spm_dir '/tpm/TPM.nii,3']);
matlabbatch{4}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{4}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(4).tpm = cellstr([spm_dir '/tpm/TPM.nii,4']);
matlabbatch{4}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{4}.spm.spatial.preproc.tissue(4).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(5).tpm = cellstr([spm_dir '/tpm/TPM.nii,5']);
matlabbatch{4}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{4}.spm.spatial.preproc.tissue(5).native = [1 0];
matlabbatch{4}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(6).tpm = cellstr([spm_dir '/tpm/TPM.nii,6']);
matlabbatch{4}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{4}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{4}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{4}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{4}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{4}.spm.spatial.preproc.warp.reg = [0 0 0.1 0.01 0.04];
matlabbatch{4}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{4}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{4}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{4}.spm.spatial.preproc.warp.write = [0 1];
matlabbatch{4}.spm.spatial.preproc.warp.vox = NaN;
matlabbatch{4}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
                                              NaN NaN NaN];
matlabbatch{5}.spm.spatial.normalise.write.subj.def(1) = cfg_dep('Segment: Forward Deformations', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','fordef', '()',{':'}));
matlabbatch{5}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep('Slice Timing: Slice Timing Corr. Images (Sess 1)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{5}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{5}.spm.spatial.normalise.write.woptions.vox = [3 3 3];
matlabbatch{5}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{5}.spm.spatial.normalise.write.woptions.prefix = 'w';
matlabbatch{6}.spm.spatial.smooth.data(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
matlabbatch{6}.spm.spatial.smooth.fwhm = [8 8 8];
matlabbatch{6}.spm.spatial.smooth.dtype = 0;
matlabbatch{6}.spm.spatial.smooth.im = 0;
matlabbatch{6}.spm.spatial.smooth.prefix = 's';

save(fullfile(sub_dir, 'preprocessing'),'matlabbatch');
%spm_jobman('interactive',matlabbatch);
spm_jobman('run',matlabbatch);