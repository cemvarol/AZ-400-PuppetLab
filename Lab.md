# Lab environment

## In this lab you will use the following two machines.

- A machine known as a _**Node**_ will host the **PU MRP** app. The only task you will perform on the node is to **install the Puppet Agent**. The Puppet Agent can run on Linux or Windows. 
For this lab, we will configure the Node in a Linux Ubuntu Virtual Machine (VM).
- A **Puppet Master machine**. The rest of the configuration will be applied by instructing Puppet how to configure the Node through Puppet Programs, on the Puppet Master. **The Puppet Master _must_ be a Linux machine**. For this lab, we will configure the Puppet Master in a Linux Ubuntu VM.

Instead of manually creating the VMs in Azure, we will use an **Azure Resource Management (ARM) Template**.

#### Task 1: Provision a Puppet Master and Node in Azure using Azure Resource Manager templates (both inside Linux Ubuntu Virtual Machines)

1. To provision the required VMs in Azure using an ARM template, select the  **Deploy to Azure**  button, and follow the wizard. You will need to log in to the Azure Portal.




[![](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2FPartsUnlimitedMRP%2Fmaster%2FLabfiles%2FAZ-400T05-ImplemntgAppInfra%2FLabfiles%2FM04%2FPuppet%2Fenv%2FPuppetPartsUnlimitedMRP.json)   [![](http://armviz.io/visualizebutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2FPartsUnlimitedMRP%2Fmaster%2FLabfiles%2FAZ-400T05-ImplemntgAppInfra%2FLabfiles%2FM04%2FPuppet%2Fenv%2FPuppetPartsUnlimitedMRP.json) [![](RackMultipart20200618-4-ix4dp6_html_c265986f7f783102.png)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft%2FPartsUnlimitedMRP%2Fmaster%2FLabfiles%2FAZ-400T05-ImplemntgAppInfra%2FLabfiles%2FM04%2FPuppet%2Fenv%2FPuppetPartsUnlimitedMRP.json)

- The VMs will be deployed to a Resource Group along with a Virtual Network (VNET), and some other required resources.

**Note:**  You can review the JSON template and script files used to provision the VMs in the [Puppet lab files folder](https://github.com/Microsoft/PartsUnlimitedMRP/tree/master/Labfiles/AZ-400T05-ImplemntgAppInfra/Labfiles/M04/Puppet) on GitHub.

2. When prompted specify a  **Subscription** ,  **Location** , and  **Resource Group**  for deploying your VM resources. Provide admin  **usernames**  and  **passwords** , as well as a unique  **Public DNS Names**  for both machines.

Consider the following guidelines.

- **Subscription:** Your Azure subscription
- **Resource group:** Provide a ne Resource group name.  E.g. **PuppetLab**. 
- - Remember to remove the resources created in this lab by deleting the Resource Group.
- **Location:**  Select a region to deploy the VMs to. E.g. **EastUs or EastUS2 or WestUs.**
- **Pm Admin Username:** The  **Pm**  refers to the Puppet Master VM use something you will remember during this lab E.g. **azureuser**.  
- **Pm Admin Password:** Set the same Admin Password for both Nodes, and for the  **Pm Console**. E.g. **Passw0rd01234**  _(This is a password for the Puppet Master Virtual Machine)_
- **Pm Dns Name For Public IP:** Include the word **_master_** in the Puppet Master DNS name, to distinguish it from the Node VM E.g. **_pmascvaz032001_** _remember to provide something unique_
- **Pm Console Password:** Provide a password for the **Puppet Master console admin account** You can use the same password E.g. **Passw0rd01234** 
- **Mrp Admin Username:** The  **Mrp**  refers to the Puppet Node VM use something you will remember during this lab E.g. **azureuser**. 
- **Mrp Admin Password:** Set the same Admin Password for this node like the others.  E.g. **Passw0rd01234**   _(This is a password for the Puppet Master Virtual Machine)_
- **Mrp Dns Name For Public IP:** Include the word **_node_** in the Puppet Master DNS name, to distinguish it from the Node VM E.g. **_pnodecvaz032001_** _remember to provide something unique_

##### Make a note of the location region, as well as any usernames and passwords you set for the VMs.


#
#
#
![](https://raw.githubusercontent.com/cemvarol/AZ-400-PuppetLab/master/01-CustomDeployment.png)

Use the  **checkbox**  to agree to the Azure Marketplace terms and conditions. Select the  **Purchase**  button. Allow about 10 minutes for each deployment to complete.

1. When the deployment completes, select the  **Resource Groups**  blade from the Azure Portal menu. Choose the name of Resource Group that you created,  **cd-puppet-hol**  for example.

![](RackMultipart20200618-4-ix4dp6_html_d3bf8d9c80d50dbd.png)

1. Within the  **Resource Group Overview**  pane, beside  **Deployments** , select the  **1 succeeded**  message to view the deployment details. The status of the Microsoft.Template resource should indicate that the deployment has  **succeeded**.

Choose the Microsoft.Template resource, listed in the  **Deployment Name**  column.

![](RackMultipart20200618-4-ix4dp6_html_a71653f7990a3a06.png)

1. There is a list of the deployed resources in the  **Microsoft.Template - Overview**  pane, below the  **Your deployment is complete**  message. Select the  **Puppet Master VM**  from the list, for example partspuppetmasterek01.

![](RackMultipart20200618-4-ix4dp6_html_7d4bb0429d80e4e6.png)

1. Make a note of the  **DNS name**  value, listed inside the  **Overview**  pane for the  **Puppet Master Virtual Machine**. The DNS name value is in the format machinename.region.cloudapp.azure.com. For example, partspuppetmasterek01.northeurope.cloudapp.azure.com.

![](RackMultipart20200618-4-ix4dp6_html_159047e715056b6d.png)

1. Append https:// to the beginning of the DNS name to create a URL for the Puppet Master&#39;s public DNS Address. The resulting URL should be in the format https://machinename.region.cloudapp.azure.com. For example, https://partspuppetmasterek01.northeurope.cloudapp.azure.com.

Using https, _not_ http, visit the URL in a web browser.

Override the certificate error warning messages, and visit the webpage. It is safe to ignore these error messages for the purposes of this lab. The prompts that you see, and steps required to access the URL, may depend on the web browser you use.

![](RackMultipart20200618-4-ix4dp6_html_fb8eb97e0dc5d19b.png)

1. If the Puppet configuration has succeeded, you should see the  **Puppet Master Console sign in webpage**.

![](RackMultipart20200618-4-ix4dp6_html_eccbe8c11d1d869d.png)

**Note:**  The lab requires several ports to be open, such as the Puppet Server port, the Puppet Console port, SSH ports, and the PU MRP app port on the partsmrp VM. The ARM template opens these ports on the VMs for you. You can look through the deployment JSON template to view the port configuration details in the [PuppetPartsUnlimitedMRP.json](https://github.com/Microsoft/PartsUnlimitedMRP/tree/master/Labfiles/AZ-400T05-ImplemntgAppInfra/Labfiles/M04/Puppet/env/PuppetPartsUnlimitedMRP.json) file on GitHub.

1. Log in to the  **Puppet Master Console**  with the following credentials.
  - **user name**  = admin
  - **Password**  = Pm Console Password you specified earlier in this lab. For example, Passw0rd0134

**Note:**  You cannot log into the Puppet Master Console with the username and password you specified earlier in this lab. _You must login using the built in  __admin__  account_ instead, as shown.

1. If your log in is successful, you will be redirected to the  **Puppet Configuration Management Console**  webpage which is similar in appearance to the following screenshot.

![](RackMultipart20200618-4-ix4dp6_html_bf5f45a5744d5d1c.png)

Task 2: Install Puppet Agent on the node

You are now ready to add the Node to the Puppet Master. Once the Node is added, the Puppet Master will be able to configure the Node.

1. Get the Puppet Master internal DNS name. On the  **Puppet Configuration Management Console**  webpage, go to  **Nodes**  \&gt;  **Unsigned Certificates**. The page that loads will show an Add node command. Make a note of the command, we will run it in Step 4 of this lab task.

For example, the Puppet Master machine name is partspuppetmasterek01.northeurope.cloudapp.azure.com, and the command we need to run will be similar to the following command.

curl **-k** https://partspuppetmasterek01.irblmudbrloe5hz001blu2g34f.ax.internal.cloudapp.net:8140/packages/current/install.bash | sudo bash

![](RackMultipart20200618-4-ix4dp6_html_2b89d52605601131.png)

1. In Azure Portal, from the  **left menu** , choose  **All Resources**  \&gt;  **partsmrpnodeek01**  (or whatever name you specified for the Node / partsmrp VM). Make a note of the  **DNS name**  value for the Node VM.

![](RackMultipart20200618-4-ix4dp6_html_9e23c9c0689bb2fa.png)

1. Establish an SSH connection to the Node VM. In the following example, we will connect to the Node VM using the PuTTy SSH client.

Specify the Node DNS name as the destination  **Host Name**.

![](RackMultipart20200618-4-ix4dp6_html_17c0646dd8595325.png)

If prompted, choose  **Yes**  to add the SSH key to PuTTy&#39;s cache.

![](RackMultipart20200618-4-ix4dp6_html_67fc264a415505bd.png)

Log in with username and password credentials that you specified in Task 1. For example, azureuser and Passw0rd0134.

![](RackMultipart20200618-4-ix4dp6_html_bb92b8717de9fbb3.png)

1. Run the Add Node command on the node.

Enter the Add Node command into the SSH terminal, which you noted earlier in Step 1. The command begins with curl.... Run the command.

![](RackMultipart20200618-4-ix4dp6_html_124dacfe6fd250bc.png)

Wait for the command to install the Puppet Agent and any dependencies on the Node. The command takes two or three minutes to complete.

![](RackMultipart20200618-4-ix4dp6_html_235622fb6a1f82fc.png)

From here onwards, you will configure the Node from the Puppet Master only.

1. Accept the pending Node request.

Return to the  **Puppet Configuration Management Console**.  **Refresh**  the  **Unsigned Certificates**  webpage (where you previously got the Node install command). You should see a pending unsigned certificate request. Choose  **Accept**  to approve the node.

This is a request to authorize the certificate between the Puppet Master and the Node, so that they can communicate securely.

![](RackMultipart20200618-4-ix4dp6_html_454f189276fa78cf.png)

1. Goto the  **Nodes**  tab in the Puppet Configuration Management Console. It may take a few minutes to configure the Node / partsmrp VM, before it is visible in the Puppet Configuration Management Console. When the Node is ready, you should see the following nodes listed in the Puppet Configuration Management Console.
  - Puppet Master. For example, partspuppetmasterek01
  - Node / partsmrp. For example, partsmrpnodeek01

The nodes are also listed in the Puppet Configuration Management Console under  **Configuration**  \&gt;  **Overview**.

![](RackMultipart20200618-4-ix4dp6_html_9aadde7eb3d2f2fd.png)

**Note:**  You can automate the Puppet Agent installation and configuration process on an Azure VM using the [Puppet Agent extension](https://github.com/Azure/azure-quickstart-templates/tree/master/puppet-agent-windows) from the Azure Marketplace.

There are also a series of PowerShell cmdlets for provisioning, enabling, and disabling the Puppet Extension Handler on Windows VMs. This provides a command-line interface for deploying Puppet Enterprise Agents to Windows VMs in Azure. For details see the [Puppet PowerShell Cmdlets for Azure Guide](https://puppet.com/sites/default/files/Microsoft-Powershell-cmdlets.pdf).

Puppet modules and programs

The Parts Unlimited MRP application (PU MRP App) is a Java application. The PU MRP App requires you to install and configure [MongoDB](https://www.mongodb.org/) and [Apache Tomcat](https://tomcat.apache.org/) on the Node / partsmrp VM. Instead of installing and configuring MongoDB and Tomcat manually, we will write a Puppet Program that will instruct the Node to configure itself.

Puppet Programs are stored in a particular directory on the Puppet Master. Puppet Programs are made up of _manifests_ that describe the desired state of the Node(s). The manifests can consume _modules_, which are pre-packaged Puppet Programs. Users can create their own modules or consume modules from a marketplace that is maintained by Puppet Labs, known as [The Forge](https://forge.puppetlabs.com/).

Some modules on The Forge are supported officially, others are open-source modules uploaded from the community. Puppet Programs are organized by environment, which allows you to manage Puppet Programs for different environments such as _Dev_, _Test_ and _Production_.

For this lab, we will treat the Node as if it were in the Production environment. We will also download modules from The Forge, which we will consume in order to configure the Node.

Task 3: Configure the Puppet Production Environment

The template we used to deploy Puppet to Azure also configured a directory on the Puppet Master for managing the Production environment. The Production Directory is in /etc/puppetlabs/code/environments/production.

1. Inspect the Production modules.

Connect to the to the Puppet Master via SSH, with the PuTTy client for example. Use the Change Directory command cd to change into the Production Directory /etc/puppetlabs/code/environments/production.

cd /etc/puppetlabs/code/environments/production

Use the list command ls to list the contents of the Production Directory. You will see directories named manifests and modules.

- The manifests directory contains descriptions of machines that we will apply to Nodes later in this lab.
- The modules directory contains any modules that are referenced by the manifests.

![](RackMultipart20200618-4-ix4dp6_html_cb3fc7566f98b2bd.png)

1. Install additional Puppet Modules from The Forge.

We will install modules from The Forge that are needed to configure the Node / partsmrp. Run the following commands in a terminal with an SSH connection to the Puppet Master.

sudo puppet module install puppetlabs-mongodb

sudo puppet module install puppetlabs-tomcat

sudo puppet module install maestrodev-wget

sudo puppet module install puppetlabs-accounts

sudo puppet module install puppetlabs-java

![](RackMultipart20200618-4-ix4dp6_html_46fe02de931017f5.png)

**Note:**  The mongodb and tomcat modules from The Forge are supported officially. The wget module is a user module, and is not supported officially. The accounts module provides Puppet with _Classes_ for managing and creating users and groups in our Linux VMs. Finally, the java module provides Puppet with additional Java functionality.

1. Create a custom module.

Create a custom module named mrpapp in the Production/ Modules Directory on the Puppet Master. The custom module will configure the PU MRP app. Run the following commands in a terminal with an SSH connection to the Puppet Master.

Use the Change Directory command cd to change into the Production/ Modules Directory /etc/puppetlabs/code/environments/production/modules.

cd /etc/puppetlabs/code/environments/production/modules

Run the module generate commands to create the mrpapp module.

sudo puppet module generate partsunlimited-mrpapp

This will start a wizard that will ask a series of questions as it scaffolds the module. Simply press enter for each question (accepting blank or default) until the wizard completes.

Running list command ls -la should show a list of the modules in the directory ~/production/modules, including the new mrpapp module.

![](RackMultipart20200618-4-ix4dp6_html_aab2d88959ef1af2.png)

**Note:**  The ls -la combined commands will list the contents of a directory (i.e. ls), using a long list format (i.e. -l), with hidden files shown (i.e. -a).

1. The mrpapp module will define our Node&#39;s configuration.

The configuration of Nodes in the Production environment is defined in a site.pp file. The site.pp file is located in the Production \ Manifests directory. The .pp filename extension is short for _Puppet Program_.

We will edit the site.pp file by adding a configuration for our Node.

On your PuTTy session of Master node please run the following.

_mkdir /tmp/cem_

_#git pull_

_cd /tmp/cem_

_git clone https://github.com/cemvarol/AZ-400-PuppetLab_

_cd /tmp/cem/AZ-400-PuppetLab_

**After download completed please run this.**

_sudo cp /tmp/cem/AZ-400-PuppetLab/site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp_

**Note:**  This will download the edited files for the necessary steps, and set site.pp file as expected.

Task 4: Test the Production Environment Configuration

Before we describe the PU MRP app for the Node fully, test that everything is hooked up correctly by configuring a _dummy_ file in the mrpapp module. If Puppet executes and creates the dummy file successfully, then everything is configured and working correctly. We can then set up the mrpapp module properly.

1. Edit the init.pp file.

Please run the command below.

_sudo cp /tmp/cem/AZ-400-PuppetLab/init.pp /etc/puppetlabs/code/environments/production/modules/mrpapp/manifests/init.pp_

1. Test the dummy file.

To test our setup, establish an SSH connection to the Node / partsmrp VM (using the PuTTy client, for example). Run the following command in an SSH terminal to the Node.

sudo puppet agent **--test**** --debug**

![](RackMultipart20200618-4-ix4dp6_html_b6bd1a795531548f.png)

By default, Puppet Agents query the Puppet Master for their configuration every 30 minutes. The Puppet Agent then tests its current configuration against the configuration specified by the Puppet Master. If necessary, the Puppet Agent modifies its configuration to match the configuration specified by the Puppet Master.

The command you entered forces the Puppet Agent to query the Puppet Master for its configuration immediately. In this case, the configuration requires the /tmp/dummy.txt file, so the Node creates the file accordingly.

You may see more output in your terminal than is shown in the previous screenshot. We used the --debug switch for learning purposes, to display more information as the command executes. You can remove the --debug switch to receive less text output in the terminal if you wish.

You can also use the cat command on the Node, to verify the presence of the file /tmp/dummy.txt on the Node, and to inspect the file&#39;s contents. The &quot;Puppet rules!&quot; message should be displayed in the terminal.

cat /tmp/dummy.txt

![](RackMultipart20200618-4-ix4dp6_html_668a334f5b65215f.png)

1. Correct configuration drift.

By default, Puppet Agent runs every 30 minutes on the Nodes. Each time the Agent runs, Puppet determines if the environment is in the correct state. If it is not in the correct state, Puppet reapplies Classes as necessary. This process allows Puppet to detect _Configuration Drift_, and fix it.

Simulate Configuration Drift by deleting the dummy file dummy.txt from the Node. Run the following command in a terminal connected to the Node to delete the file.

sudo rm /tmp/dummy.txt

Confirm that the file was deleted from the Node successfully by running the following command on the Node. The command should produce a _No such file or directory_ warning message.

cat /tmp/dummy.txt

Re-run the Puppet Agent on the Node with the following command.

sudo puppet agent **--test**

The re-run should complete successfully, and the file should now exist on the Node again. Verify that the file is present on the Node by running the following command on the Node. Confirm that the &quot;Puppet rules!&quot; message is displayed in the terminal.

cat /tmp/dummy.txt

![](RackMultipart20200618-4-ix4dp6_html_f4f5724100287ac4.png)

You can also edit the contents of the file dummy.txt on the Node. Re-run the sudo puppet agent --test command, and verify that the contents of the file dummy.txt have been reverted to match the configuration specified on the Puppet Master.

Task 5: Create a Puppet Program to describe the prerequisites for the PU MRP app

We have hooked the Node (partsmrp) up to the Puppet Master. Now we can write the Puppet Program to describe the prerequisites for the PU MRP app.

In practice, the different parts of a large configuration solution are typically split into multiple manifests or modules. Splitting the configuration across multiple files is a form of _Modularization_, and promotes better organization and reuse of code.

For simplicity, in this lab, we will describe our entire configuration in a single Puppet Program file init.pp, from inside the mrpapp module that we created earlier. In Task 5, we will build up our init.pp step-by-step.

Task 5.1 Configure MongoDB

Task 5.2 Configure Java

Task 5.3 Create User and Group

Task 5.4 Configure Tomcat

Task 5.5 Deploy a WAR File

Task 5.6 Start the Ordering Service

Task 5.7 Complete the mrpapp Resource

**Please run the command below for all 8 tasks above on Master NODE…**

_sudo cp /tmp/cem/AZ-400-PuppetLab/init2.pp /etc/puppetlabs/code/environments/production/modules/mrpapp/manifests/init.pp_

Task 5.8 Configure .war file extracton permissions

**Please run the command below for task 5.8**

_sudo cp /tmp/cem/AZ-400-PuppetLab/war.pp /etc/puppetlabs/code/environments/production/modules/tomcat/manifests/war.pp_

Task 6: Run the Puppet Configuration on the Node

1. Re-run the Puppet Agent.

Return to, or re-establish, your SSH session on the Node/ partsmrp VM. Force Puppet to update the Node&#39;s configuration with the following command.

sudo puppet agent **--test**

**Note:**  This first run may take a few moments, as there is a lot to download and install. The next time that you run the Puppet Agent, it will verify that the existing environment is configured correctly. This verification process will take less time than the first run, because the services will be installed and configured already.

1. Verify that Tomcat is running correctly.

Append the port number 9080 to the DNS address URL for the Node/ partsmrp VM, for example http://partsmrpnodeek01.westeurope.cloudapp.azure.com:9080

You can get the DNS address URL from the  **Public IP resource**  for the Node, in  **Azure Portal**  (just as you did when you got the URL of the Puppet Master earlier).

Open a web browser and browse to port 9080 on the Node/ partsmrp VM. Once open in the web browser, you should see the  **Tomcat Confirmation**  webpage.

**Note:**  Use the http protocol, and _not_ https.

![](RackMultipart20200618-4-ix4dp6_html_b1f98e642573b865.png)

1. Verify that the PU MRP app is running correctly.

Check that the configuration is correct by opening a web browser to the PU MRP app. In your web browser, append /mrp to the end of DNS address URL you used in Step 2. For example, http://partsmrpnodeek01.westeurope.cloudapp.azure.com:9080/mrp.

You can also get the DNS name for the Node/ partsmrp VM in  **Azure Portal**.

The  **PU MRP app Welcome**  webpage should be displayed in your web browser.

![](RackMultipart20200618-4-ix4dp6_html_9507eba1c9a16e2.png)

Explore the PU MRP app to confirm that it functions as intended. For example, select the  **Orders**  button, in your web browser, to view the  **Orders page**.

![](RackMultipart20200618-4-ix4dp6_html_4723524f7d4f44f9.png)
