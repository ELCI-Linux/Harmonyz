#! /bin/bash/

	helper="Harmonyz"
	versnum="1.2"

	zenity --notification \
	--text="$helper $versnum"

	zenity --info \
	--title="$helper $versnum" \
	--width=500 \
	--text="Welcome to $helper. This program can be used to install a variety of audio players, including DSPs. To support ELCI and other crypto creators, consider installing Audius."

	harmony=$(zenity --list \
	--height=480 --width=400 \
	--checklist --title="$helper $versnum" \
	--text="Select your Audio Players" \
	--column="Selected" --column="Music Player" --column="Content Source" \
	"" "Apple Music" "DSP" \
	"" "Audacious" "Local" \
	"" "Audius" "Blockchain" \
	"" "Byte" "Local" \
	"" "CMUS" "Local" \
	"" "Deezer" "DSP" \
	"" "Gnome Music Player" "Local" \
	"" "Hydrogen" "Local" \
	"" "Lyrics" "Local" \
	"" "Spotify" "DSP" \
	"" "Strawberry" "Local (Install for Tidal)"
	"" "VVave"	"Local")


	APPLE_MUSIC=$(echo $harmony | grep -c "Apple Music")
	if [ $APPLE_MUSIC -gt '0' ]; then
 	sudo apt-get install snap snapd -yy
	sudo snap install apple-music-for-linux
	fi

	AUDACIOUS=$(echo $harmony | grep -c "Audacious")
	if [ $AUDACIOUS -gt '0' ]; then
	flatpak install flathub org.atheme.audacious -yy
	fi

	AUDIUS=$(echo $harmony | grep -c "Audius")
	if [ $AUDIUS -gt '0' ]; then
	wget "https://download.audius.co/Audius%200.16.6.AppImage" -O ./Audius.AppImage
	chmod u+x ./Audius.AppImage
        ./Audius.AppImage && \
		zenity --question --text="Audius has been installed, would you like to delete the AppImage?"
		if [ $? -eq "0" ]; then
		rm ./Audius.AppImage
		fi
	fi

	BYTE=$(echo $harmony | grep -c "Byte")
	if [ $BYTE -gt '0' ]; then
	flatpak install flathub com.github.alainm23.byte -y
	fi

	DEEZER=$(echo $harmony | grep -c "Deezer")
	if [ $DEEZER -gt '0' ]; then
	sudo apt-get install flatpak -yy
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --if-not-exists nuvola https://dl.tiliado.eu/flatpak/nuvola.flatpakrepo
	flatpak update yy
	flatpak install nuvola eu.tiliado.NuvolaAppDeezer -y && flatpak run eu.tiliado.NuvolaAppDeezer -y
	flatpak run eu.tiliado.NuvolaAppDeezer
	fi

	CMUS=$(echo $harmony | grep -c "CMUS")
	if [ $CMUS -gt '0' ]; then
	sudo apt-get install libao-ocaml-dev cmus -y
	fi

	GNOME_MUSIC=$(echo $harmony | grep -c "Gnome Music Player")
	if [ $GNOME_MUSIC -gt '0' ]; then
	flatpak install flathub org.gnome.Music -y
	fi

	HYDROGEN=$(echo $harmony | grep -c "Hydrogen")
	if [ $HYDROGEN -gt '0' ]; then
	flatpak install org.hydrogenmusic.Hydrogen -y
	fi

	LYRICS=$(echo $harmony | grep -c "Lyrics")
	if [ $LYRICS -gt '0' ]; then
	flatpak install flathub com.github.naaando.lyrics -y
	fi

	SPOTIFY=$(echo $harmony | grep -c "Spotify")
	if [ $SPOTIFY -gt '0' ]; then
	flatpak install flathub com.spotify.Client -y
	fi

	SPOTIFY_CLI=$(echo $harmony | grep -c "Spotify-CLI")
	if [ $SPOTIFY_CLI -gt "0" ]; then
	cargo install spt
	fi

	STRAWBERRY=$(echo $harmony | grep -c "Strawberry")
	if [ $STRAWBERRY -gt '0' ]; then
	sudo add-apt-repository ppa:jonaski/strawberry
	sudo apt-get update
	sudo apt-get install strawberry -y
		zenity --question --title="Tidal Support?" --text="Harmony has detected you have successfully installed Strawberry. Would you like to add TIDAL support?"
		if [ $? -gt '0' ]; then
		sudo mkdir ./TIDAL-API

			API=$(zenity --list --checklist --title="TIDAL API Source?" --text="Harmonyz needs access to your TIDAL APIs to complete this process. Please select a platform where you have an existing installation of TIDAL available." --column="Selected" --column="Platform" "" "Android" "" "Locate Manually (Windows)")

			APIA=$(echo $API | grep -c "Android")
			if [ $APIA -gt '0' ]; then
			adb pull /storage/emulated/0/Android/data/com.aspiro.tidal/cache
			fi

			APIW=$(echo $API | grep -c "Locate Manually (Windows)")
			if [ $APIW -gt '0' ]; then
			APILOC=$(zenity --file-selection --directory)

		#backup conf and replace with tidal compatible version
		mkdir ./confbackups
		sudo cp ~/.config/pulse/daemon.conf ./confbackups &&
		sudo cp -i ./confbackups/daemon.conf ~/.config/pulse/daemon.conf && zenity --info --title="Harmonyz:TIDAL" --text="Your existing 'daemon.conf' file was replaced with a TIDAL Hi-Fi compatible version, a back-up is stored at ./confbackups"
		rm Harmony.txt

			cp $APILOC ./TIDAL-API
			fi
		fi

	fi

	VVAVE=$(echo $harmony | grep -c "Vvave")
	if [ $VVAVE -eq "1" ]; then
	flatpak --system install org.kde.vvave -y
	fi

#Finish

	zenity --question --title="$helper $versnum: Finished" \
	--width=500 \
	--text="Thank you for using Harmonyz, you can support the development of this software and similar projects by donating BAT via our github page. Would you like to visit the ELCI-Linux github profile?"
		if [ $? -eq '0' ]; then
		xdg-open https://github.com/ELCI-Linux
		fi


