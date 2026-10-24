# SPM MRI Course: Advanced fMRI

Materials for a [SPM MRI Course](https://fil.ion.ucl.ac.uk/spm/docs/courses/fmri_vbm/) workshop on advanced fMRI analysis. The accompanying [slides](advanced_fmri.pdf) cover visual quality control, motion-related artifacts and correction, accounting for within- and between-participant variability, optimising experimental design, and performing image calculations.

## Practical materials

| Directory | Included files and exercises |
| --- | --- |
| [`motion/`](motion/) | [`motion.mlx`](motion/motion.mlx), a MATLAB Live Script for examining motion, calculating framewise displacement (FD), identifying outlier volumes, and exploring censoring and expanded motion regressors. The example includes a preprocessed [auditory BOLD fMRI data](https://fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/block/) and realignment parameters (`rp`). |
| [`parametric_modulation/`](parametric_modulation/) | Data from a [faces fMRI task](https://fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/) for one participant, including BOLD fMRI, structural data, and `sots.mat` task onsets. A preprocessing script and two first-level GLM scripts are also included. Compare a [categorical model](https://fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/categorical/) with a [parametric-modulation model](https://fil.ion.ucl.ac.uk/spm/docs/tutorials/fmri/event/parametric/). The latter uses item lag (`Lag`) for conditions `N2` and `F2`. |
| [`group_regressors/`](group_regressors/) | Precomputed first-level SPM outputs for 10 participants. `second_level.m` demonstrates a group one-sample t-test, while `second_level_age.m` adds age from `age.mat` and tests positive and negative age associations. |
| [`imcalc/`](imcalc/) | Structural MRI and SPM tissue-segmentation images (`c1`–`c5` and bias-corrected `m`)`. Use these with the slide examples to explore ImCalc. |

## Getting started

The MATLAB scripts use SPM batch functions, so install MATLAB and SPM and add SPM to the MATLAB path before running them. Open `motion/motion.mlx` in MATLAB's
Live Editor. For the parametric-modulation exercise, run `parametric_modulation/preprocessing.m` before either first-level script; the preprocessing step unpacks the compressed BOLD data and creates the files used by the first-level models. The group-regressor scripts use the supplied first-level contrast images and age values. The ImCalc exercise uses the included structural and tissue images with SPM's ImCalc interface.

Running the scripts creates outputs in the exercise directories. Review each batch and its input/output paths before running, especially if rerunning an exercise or working with a copy of these data.

## Related materials

The repository complements the [tutorials](https://fil.ion.ucl.ac.uk/spm/docs/tutorials/) and [lecture materials](https://fil.ion.ucl.ac.uk/spm/docs/courses/fmri_vbm/recordings/) covered in the SPM MRI Course. 
