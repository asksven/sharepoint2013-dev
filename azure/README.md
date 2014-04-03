# Introduction
This is a set of scripts for provisioning developer images on azure. Pre-requirement is that the Azure powershell extensions are installed (http://www.windowsazure.com/downloads/) sand configured (http://www.windowsazure.com/en-us/documentation/articles/install-configure-powershell/#Install)

# Rationale
We have scripts to create developer images from scratch based on an empty windows server 2012 image. The major drawback of having every developer go through the workflow of provisioning his image is that this exercise takes up a few hours. On the other hand single Sharepoint servers can not be syspreped.

# Workflow
For that reason we chose to implement a workflow based on cloning:
* we maintain a master VM that was created from the provisioning scripts
* when creating a new developer VM we copy the master VHD, instanciate a new disk and create a VM based on that disk

# Scripts
## Release a new master VHD
New master VHD releases are created whenever required, either to fix bug in the previous release or when Service Packs or CUs are applied.

  MakeRelease.ps1 : copies the master VHD (source staorage account) to the VHD release repository
   
## Create a developer server
