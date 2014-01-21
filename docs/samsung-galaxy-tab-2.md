# Deployment Instructions
## Samsung Galaxy Tab 2, 7"

### Prerequisites 

**(only needs to happen once)**

These instructions assume an OS X computer connected to internet.  Many steps require running the commands in a "Terminal" window.  You can find this in <code>Applications->Utilities->Terminal</code> on your computer.  The commands should be run one line at a time (don't include the "$" in the command).

1. Install Xcode: [http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)

3. Download and Install Android Developer Toolkit: [http://developer.android.com/sdk/index.html](http://developer.android.com/sdk/index.html)
4. Download and Install Heimdall (make sure command line tool is installed): [http://glassechidna.com.au/heimdall/](http://glassechidna.com.au/heimdall/)
4. Install [Homebrew](http://brew.sh/) on your machine

        $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
        

3. Install git

        $ brew update
        $ brew install git


5. Set up commissioning environment

        $ cd ~
        $ mkdir projects
        $ cd projects
        $ git clone https://github.com/thegloballiteracyproject/globallit_deployment.git
        
6. Download commissioning image. (replace <COMMISIONING_IMAGE_URL> with supplied url)

        $ cd ~/projects/globallit_deployment/
        $  wget -r --no-parent --reject "index.html*" -nH --cut-dirs=2 <COMMISIONING_IMAGE_URL>

7. Download setup script (replace <SETUP_SCRIPT_URL> with supplied url)

        $ cd ~/projects/globallit_deployment/scripts
        $  wget -r --no-parent --reject "index.html*" -nH --cut-dirs=2 <SETUP_SCRIPT_URL>

7. Adjust deployment parameters by editing ~/projects/scripts/setup.sh with supplied values

        export DEPLOYMENT_CODE="<DEPLOYMENT_CODE>"
        export VERSION="<VERSION>"
        export TUNNEL_PORT_PREFIX="<TUNNEL_PORT_PREFIX>"

### Rooting and Installing Image

2. Put unplugged, powered-off samsung tablet into flash mode by holding the power and down-volume buttons at the same time until a "Warning!!" screen appears.

3. Press the volume-up button to prepare the tablet for recovery image upload (You will see "Downloading" on the screen)

4. **Connect tablet to laptop using USB cable**

1. Start Deployment Script (replace TABLET_ID with a unique id (ex. "101", "102", etc) per tablet)

        $ cd ~/projects/globallit_deployment
        $ source ./scripts/setup.sh
        $ source ./scripts/deploy.sh TABLET_ID


    You should see something like:
    
        Installing Version: 3.0.3-samsung-galaxy-tab-2
        Tablet: MIT-101
        Tunnel Port: 45101
        Press [Enter] key to start Flash...
        
2. Press [Enter] on your laptop to start Recovery Flash (this should take 5-10 seconds to complete)

3. **Disonnect tablet from laptop**

4. Press the power and volume-up button at the same time until you see the Samsung logo appear.

5. **Connect tablet to laptop using USB cable**

6. Press [ENTER] on your laptop when you see the TeamWin Recovery menu (a grid of 8 buttons)

    The image is now copying to your tablet.  It will take 5-10 minutes to complete.

7. When the copying is complete, the tablet will reboot and start the installation process (you will see "Deploy Script Complete. OK To disconnect tablet." on your laptop).  At this point, you can disconnect the tablet from your laptop.  (The installation step on the tablet takes about 5 minutes)

    While the tablet is installing, you can start the next tablet installation.
