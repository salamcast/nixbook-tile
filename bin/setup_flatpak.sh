

# add flatpack name to list
fp=$(cat << EOF
org.libreoffice.LibreOffice
EOF
)
for x in $fp
do
  echo -e "$x \n"
  flatpak install flathub $x -y
done


# Add flathub and some apps
flatpak install flathub us.zoom.Zoom -y
# Fix for zoom flatpak
flatpak override --env=ZYPAK_ZYGOTE_STRATEGY_SPAWN=0 us.zoom.Zoom