#Add tpm2-tss module to the dracut configuration
echo "add_dracutmodules+=\" tpm2-tss \"" | sudo tee /etc/dracut.conf.d/tpm2.conf
add_dracutmodules+=" tpm2-tss "

# Enroll the TPM2 chip
sudo systemd-cryptenroll --wipe-slot tpm2 --tpm2-device auto --tpm2-pcrs "0+1+2+3+4+5+7" /dev/nvme0n1p3

# Rebuild initramfs
sudo dracut -f