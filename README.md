# Introduction
This package lets you edit M Routines and Look at globals using Eclipse. It also includes a non-functional terminal and Debugging capabilities which are close to being done but are not quite there yet.

# Installation
## Requirements
 - Recent Eclipse. Tested on Luna and Kepler.
 - Java 1.7. YOU MUST CHECK FOR THAT USING YOUR OS'S COMMAND LINE. ECLISPE DOES NOT WARN YOU IF IT CAN'T LOAD IT. I have not tried Java 1.8.

## How to install
 - On Eclipse, Menu Help > Install New Software...
 - Click Add
 - Enter `M-tools` in first field and `https://raw.githubusercontent.com/shabiel/M-Tools-Project/master/MToolsUpdateSiteProject/` on the next.
 - Click on Next, Next, Accept the license, Finish.
 - Override the warning about unsigned content
 - On the VISTA server, install this build: https://raw.githubusercontent.com/shabiel/M-Tools-Project/master/MiscDependencies/KIDS/M-Editor/XT73P101T9.KID
 
# Brief Usage Tutorial
 1. Make sure that you have a VistALink port open on your VISTA environment. Cache users can use the XOBU SITE SETUP MENU to start a port. GT.M users need to use a xinetd listener that invokes `GTMLNX^XOBVTCP`.
 1.5 MAKE SURE YOU HAVE the key XUPROGMODE.
 2. Menu Window > Preferences > VistA. Give the server a name and add its ip address and port number for your VistALink port.
 3. Hit OK, OK.
 4. Open M Prespective by Window > Open Prespective > Other > VistA. You may need to resize your prespective  "restoring" the Windows.
 5. Create a new Project, or import a git repository. You can google the latter. For the first, File > New > Project > General > Project. Choose a name and hit okay. 
 6. On the Project Exlporer on your upper left corner, right click on the Project, choose Properties, then choose VistA. Type in the name *exactly* of your VistA server that you set up in Step 2. Hit OK.
 7. Click on Menu VistA > Connect to VistA. You should see a screen asking you for the access and verify code. If you don't see this screen, you need to check all your settings, down to whether you can even connect to the VistALink port from netcat or telnet.
 8. Once you are signed in, you can use the VistA menu or the ugly green M button to load a routine. Saving is done using the regular Eclipse Save. To create a new routine (an extraordinarily difficult thing to do in Cache BTW), Menu File > New > VistA Routine.
 
 That's it.
 
 There is detailed usage documentation in the repository.

# Plug-in Development guidance

MTools imported as an Eclipse project.

Can be ran via opening the plugin.xml of a given projecting and clicking run or debug in the upper right corner.

Or alternatively just to copy the files from /MtoolsUpdateSiteProject/plugins (the 3 jar plugin files) into $ECLIPSE_HOME/dropins.

Can also use the project 'MToolsUpdateSite' to create and deploy p2 update site later (as is done in RASR).


Notes:
Refer to /MiscDependencies and /docs for complete installation details.
