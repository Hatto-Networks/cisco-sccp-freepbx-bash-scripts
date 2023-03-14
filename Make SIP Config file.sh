#!/bin/bash
# This script generates a SIP Config File for Cisco phones. I get it's not exactly SCCP-related, but still useful.

echo -e "Welcome to the SIP Config Generator for Cisco phones. Ensure you have made an extension and configured everything beforehand. If you need help watch the guide at https://hatl.ink/ciscofreepbxvid"
echo -e "\nFirst, enter your phone's MAC Address. It's 12 characters and can be found on the back label or in your phone settings > Network Configuration"
read mac
echo -e "\nNext, enter your PBX's IP Address. Make sure it's not 127.0.0.1."
read pbxip
echo -e "\nNow, enter your SIP Port. It should be 5160 if you're using chan_sip."
read pbxport
echo -e "\nNext, enter your Extension number."
read extnum
echo -e "\nNow, your Extension's secret. It must be numerical and 8 characters, because Cisco phones are picky."
read extpw
echo -e "\nNow enter your Phone label, aka the text that appears in the top right corner of the phone screen."
read phonelabel
echo -e "\nPlease confirm the following information:\n\nMAC Address: $mac\nPBX IP Address: $pbxip\nPBX SIP Port: $pbxport\nExtension Number: $extnum\nExtension Secret: $extpw\nPhone Label: $phonelabel"
echo -e "\n\nIf all of this is correct, type YES. If not, type NO or anything else."
read confirm

if [ "$confirm" == "YES" ]; then
    echo -e "\nOK, let's do this then."
    echo -e "\n\nGetting the config template..."
    wget -q https://hatto.dev/res/phonetemplate.xml
    wget -q https://hatto.dev/res/cisco_dialplan.xml
    echo -e "Doing some magic..."
    sed -i "s/PBXIP/$pbxip/g" ./phonetemplate.xml && sed -i "s/PBXPORT/$pbxport/g" ./phonetemplate.xml && sed -i "s/EXTNUM/$extnum/g" ./phonetemplate.xml && sed -i "s/EXTPASS/$extpw/g" ./phonetemplate.xml && sed -i "s/PHONELABEL/$phonelabel/g" ./phonetemplate.xml
    mv phonetemplate.xml SEP$mac.cnf.xml
    echo -e "Your config has been made and saved to SEP$mac.cnf.xml. A required dialplan has also been saved at cisco_dialplan.xml." 
else
    echo -e "\nYou have not confirmed. Please run the script again."
    exit
fi
