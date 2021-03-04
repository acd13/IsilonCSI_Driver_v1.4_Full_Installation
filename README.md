# IsilonCSI_Driver_v1.4_Full_Installation
#README
#Author: Anjan Dave
#Version: 1.0

Disclaimer:
Everything provided in this git repository is for non-production use. It's provided as-is, use it for getting the DellEMC Isilon CSI Driver installed and then run some tests. The goal of the script is to allow you to focus on the tests and not on the underlying docker/k8s functionality.

Pre-requisites for running the scripts:
----------------------------------------
1. Have a RHEL or CentOS 7.7 (7.x should be fine i have not tested other versions) with full install - i.e., install GNOME Desktop version with dev tools, admin tools, etc installed
2. If it's going to be a VM, make sure you have 3GB memory and 2 CPUs minimum allocated
3. Have an Isilon cluster ready (real or virtual), OneFS version - anything above 8.x would be good
4. Some kubernetes background would help if the script doesn't work for you as intended!
5. Install the components - docker, k8s, and CSI Driver in that order
6. All this is valid for the Isilon CSI Driver 1.4 version only

There are two scripts provided here:
1. docker_install.sh
This script installs latest version of docker on the provided Linux host
2. install_k8s_1.19.sh
This script will install the Kubernetes 1.19.8 version for you which is what the Isilon CSI Driver currently supports
3. Install_Isilon_CSI_Driver_v1.4.sh
This script will give you all the necessary steps in a concise form to install the driver

Procedure:
--------------
Login as root to your CentOS/RHEL 7.7 VM host
cd /root
git clone https://github.com/acd13/IsilonCSI_Driver_v1.4_Full_Installation.git
cd IsilonCSI_Driver_v1.4_Full_Installation
cp *.sh /root/
./docker_install.sh (it's interactive script, complete it to get docker working)
./install_k8s_1.16.sh (it's interactive script, compleete it to get kubernetes master node working at 1.16.12)
./Install_Isilon_CSI_Driver_v1.4.sh (Follow the script prompts, or just decipher the commands and run them by hand)

Follow the official DellEMC Isilon CSI Driver 1.4 documentation at: https://github.com/dell/csi-isilon to download the offical installation guide.
