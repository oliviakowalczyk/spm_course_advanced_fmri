clear matlabbatch
spm('defaults','fMRI');
spm_jobman('initcfg');

% Directories and files
dir = fileparts(mfilename('fullpath'));
output_dir = fullfile(dir, 'second_level_age');
if ~isfolder(output_dir)
    mkdir(output_dir);
end
inputs = spm_select('FPListRec', fullfile(dir,'first_level'), '^con_0009\.nii$');
covariate = load(fullfile(dir,'age.mat'));
covariate_values = covariate.age;

% Run second-level GLM with age as a covariate
matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(output_dir);
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = cellstr(inputs);
matlabbatch{1}.spm.stats.factorial_design.cov.c = covariate_values;
matlabbatch{1}.spm.stats.factorial_design.cov.cname = 'Age';
matlabbatch{1}.spm.stats.factorial_design.cov.iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov.iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Task';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = 1;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'Age+';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'Age-';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 -1];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;

save(fullfile(output_dir, 'second_level_age.mat'),'matlabbatch');
%spm_jobman('interactive',matlabbatch);
spm_jobman('run',matlabbatch);