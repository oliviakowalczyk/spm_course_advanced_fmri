# SPM MRI Course: Advanced fMRI

Course materials for advanced fMRI analysis with SPM. The accompanying
[slide deck](advanced_fmri.pdf) covers visual quality control, motion-related
artifacts and correction, within- and between-participant variability,
experimental design, and bonus material on image orientation and ImCalc.

## Practical materials

| Directory | Included files and exercises |
| --- | --- |
| [`motion/`](motion/) | [`motion.mlx`](motion/motion.mlx), a MATLAB Live Script for examining motion, calculating framewise displacement (FD), identifying outlier volumes, and exploring censoring and expanded motion regressors. The example data are a preprocessed auditory BOLD image and six motion parameters (three translations and three rotations). |
| [`parametric_modulation/`](parametric_modulation/) | A preprocessing script and two first-level GLM scripts, with a structural image, compressed functional BOLD data, and `sots.mat` event/onset data for participant `sub-M03953`. Compare a categorical model with a parametric-modulation model: the latter uses item lag (`Lag`) for conditions `N2` and `F2`. |
| [`group_regressors/`](group_regressors/) | Precomputed first-level SPM outputs for 10 participants. Each participant has contrast images `con_0005.nii`–`con_0009.nii`; `sub-001` also includes model, beta, residual, mask, and statistical images. `second_level.m` demonstrates a group one-sample t-test, while `second_level_age.m` adds age from `age.mat` and tests positive and negative age associations. |
| [`imcalc/`](imcalc/) | Structural MRI and SPM tissue-segmentation images (`c1`–`c5` and bias-corrected `m`) for `sub-M03953`. Use these with the slide examples to explore ImCalc, including a tissue-mask-based skull-stripping expression. |

The slide deck also introduces optimizing experimental design and reviewing
design matrices. Those topics are presented in the slides; no separate design
exercise script is included here.

## Getting started

The MATLAB scripts use SPM batch functions, so install MATLAB and SPM and add
SPM to the MATLAB path before running them. Open `motion/motion.mlx` in MATLAB's
Live Editor. For the parametric-modulation exercise, run
`parametric_modulation/preprocessing.m` before either first-level script; the
preprocessing step unpacks the compressed BOLD image and creates the files
used by the first-level models. The group-regressor scripts use the supplied
first-level contrast images and age values. The ImCalc exercise uses the
included structural and tissue images with SPM's ImCalc interface.

Running the scripts creates outputs in the exercise directories. Review each
batch and its input/output paths before running, especially if rerunning an
exercise or working with a copy of these data.

## Data and reuse

The repository includes course slides, MATLAB scripts, example MRI images,
motion parameters, onset data, age values, and precomputed first-level
statistical outputs. The repository includes an MIT license; check any
additional data-source or reuse conditions that apply to the included imaging
data before redistributing them.
