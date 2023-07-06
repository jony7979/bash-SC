echo "Linux kernel:"
awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg

echo "load-grub:"
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /boot/grub/grub.cfg