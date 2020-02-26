# canary_ebr
These are the files which I use for presentations on Canary Testing with Edition-Based Redefinition.

There are several sets of files. The "prework" ones are ones which are run before performing live demos. Any files with "demo1" or "demo2" in the name are specific to one of two particular demos which this repository supports. Files with neither of those in the name are used for both demos.

Note that if any scripts which drop the ORA$BASE edition are run, future runs of the scripts would require new edition names unless some form of restore to before the ORA$BASE edition drop is performed. For these purposes, I've used a "gold image" PDB and simply clone that before performing each run of the demo which involves dropping ORA$BASE.

This repository will be a living codebase, updated over time as the presentation evolves. To allow people to see the state of the scripts as of the time of a presentation, Releases will be tagged at the time of each presentation.

Presentation Releases:
  
* v1.0 - [RMOUG Training Days 2019 (Denver, CO, USA on Feb. 21, 2019)](https://github.com/mfhaynes/canary_ebr/tree/v1.0)
* v1.1 - [Collaborate 2019 (San Antonio, TX in April 2019)](https://github.com/mfhaynes/canary_ebr/releases/tag/v1.1)
