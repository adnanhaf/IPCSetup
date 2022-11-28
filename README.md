# IPCSetup
Installation scripts for setting up IPC with Nvidia and Autoware.
# Installation steps

## Step 1. General libraries setup
Run ```$ sudo bash computer_setup.sh```

## Step 2. Nvidia drivers setup
Run ```$ sudo bash nvidia_setup.sh```

### Post Nvidia install - bios configuration
> To enter BIOS, press F2 on startup. 
> To switch the main display between CPU and GPU, go to ‘Advanced’ ->  ‘System Agent (SA) Configuration’ -> ‘Graphics Configuration’ -> ‘Primary Display’. Choose ‘PEG’ for GPU, ‘IGFX’ for CPU
> Save and Exit BIOS press F10

## Step 3. Autoware ADE setup
Run ```$ sudo bash autoware_ade_setup.sh```

## Step 4. Autoware software installation
Run ```$ sudo bash autoware_setup.sh```
