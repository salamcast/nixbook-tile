

# add flatpack name to list
flatpak << EOF
org.libreoffice.LibreOffice
EOF

for x in $flatpak
do
  flatpak install flathub $x -y
done


# Add flathub and some apps
flatpak install flathub us.zoom.Zoom -y
# Fix for zoom flatpak
flatpak override --env=ZYPAK_ZYGOTE_STRATEGY_SPAWN=0 us.zoom.Zoom