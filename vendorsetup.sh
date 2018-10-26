for combo in $(curl -s https://raw.githubusercontent.com/VenomRom/android_vendor_venom/pie/venom.devices | sed -e 's/#.*$//' | awk '{printf "venom_%s-%s\n", $1, $2}')
do
    add_lunch_combo $combo
done
