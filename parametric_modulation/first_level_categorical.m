clear matlabbatch
spm('defaults','fMRI');
spm_jobman('initcfg');

% Directories and files
dir = fileparts(mfilename('fullpath'));
sub_dir = fullfile(dir, 'sub-M03953');
output_dir = fullfile(dir, 'first_level_categorical');
if ~isfolder(output_dir)
    mkdir(output_dir);
end
input = spm_select('FPList', fullfile(sub_dir,'func'), '^swar.*\.nii$');
rp_file = spm_select('FPList', fullfile(sub_dir,'func'), '^rp_.*\.txt$');
onsets = load(fullfile(sub_dir,'sots.mat'));

% Run first-level GLM 
matlabbatch{1}.spm.stats.fmri_spec.dir = cellstr(output_dir);
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 24;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 12;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = cellstr(input);
% Condition 1
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'N1';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = onsets.sot{1};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
% Condition 2
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'N2';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = onsets.sot{2};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
% Condition 3
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).name = 'F1';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).onset = onsets.sot{3};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(3).orth = 1;
% Condition 4
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).name = 'F2';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).onset = onsets.sot{4};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(4).orth = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = cellstr(rp_file);
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact(1).name = 'Fam';
matlabbatch{1}.spm.stats.fmri_spec.fact(1).levels = 2;
matlabbatch{1}.spm.stats.fmri_spec.fact(2).name = 'Rep';
matlabbatch{1}.spm.stats.fmri_spec.fact(2).levels = 2;
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

save(fullfile(output_dir, 'first_level_categorical.mat'),'matlabbatch');
%spm_jobman('interactive',matlabbatch);
spm_jobman('run',matlabbatch);