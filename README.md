# Exchange-Documentor
# Microsoft Exchange Environment Documentor for Exchange 2010 and above
# The purpose of this script is to document an excisting Microsoft Exchange Enviroment, for the purposes of planning and sizing.
# NOTE: The intial release only supports Exchange 2010.
#
# Overview: This is a 2-part script, one part gathers the infomation from the Exchange Enviroment and the other formats in a Word Document.
#
# ON THE ANY EXCHANGE SERVER IN THE ENVIROMENT:
# Note:  The Exchange GET script must be run from a PowerShell instance that has the Exchange modules already loaded
# Copy the Get-All-Exchange2010.ps1 and HardwareInventory.ps1 scripts to the server in a new folder and run it from the Exchange Management Shell. Copy all of the resulting XML files # to a folder on a machine with Microsoft Office on it.
#
# ON A CLIENT WORKSTATION WITH WORD 2010 OR ABOVE:
# Copy the XML files created by the Get-All script as well as all PS1 files to the same folder.
# Run the Create-EX-Docs.ps1 script. (This will only load some PowerShell functions into memory. It will not produce any output.)
# Run the Docs-Exch-ToFile command. (This will open a new Word document and populate it with the Exchange data.)
#
# If you have any quesitons, please email rcorradini@live.com