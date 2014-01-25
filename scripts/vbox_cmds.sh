# create the vm
VBoxManage \
    createvm --name "testMachine" \
    --ostype Ubuntu \
    --register

# add some ram
VBoxManage \
    modifyvm testMachine \
    --memory 256


# create a bridge adapter
VBoxManage \
    modifyvm testMachine \
    --bridgeadapter1 eth0

# bridge the 1st NIC
VBoxManage \
    modifyvm testMachine \
    --nic1 bridged

# set the mac address on the 1st NIC
VBoxManage \
    modifyvm testMachine \
    --macaddress1 AAAAAAAAAAAA \
    --nictype1 82545EM

# turn on remote desktop environment
VBoxManage \
    modifyvm testMachine \
    --vrde on

# turn on multiple connects and configure a remote desktop port
VBoxManage \
    modifyvm testMachine \
    --vrdemulticon on \
    --vrdeport 3390

# add a ide controller
VBoxManage \
    storagectl testMachine \
    --name "IDE Controller" \
    --add ide \
    --controller PIIX4

# add a sata controller
VBoxManage \
    storagectl testMachine \
    --name "SATA Controller" \
    --add sata \
    --controller IntelAhci \
    --sataportcount 2

# add a iso to the cdrom drive
#VBoxManage \
#   storageattach testMachine \
#    --storagectl "IDE Controller" \
#    --port 1 \
#    --device 0 \
#    --type dvddrive \
#    --medium debian-6.0.3-amd64-i386-netinst.iso

# attach the iscsi disk ? old way??
#VBoxManage \
#    storageattach ScaryExample \
#    --storagectl "SATA Controller" \
#    --port 0 \
#    --device 0 \
#    --type hdd \
#    --medium iscsi \
#    --server 10.0.0.1 \
#    --target "iqn.2004-04.com.qnap:ts-419pplus:iscsi.example.c78d5b" \
#    --tport 3260

# possibly new way
#VBoxManage \
#    addiscsidisk \
#    --server <name>|<ip>
#    --target "iqn.2004-04.com.qnap:ts-419pplus:iscsi.example.c78d5b" \
#    --port 3260

# boot the VM
#VBoxHeadless \
#    --startvm testMachine \
#    -m 9000

# watch the boot over remote desktop
#rdesktop 172.28.202.216:3390

# delete the VM
#VBoxManage \
#    unregistervm "SUSE 10.2" \
#    --delete
