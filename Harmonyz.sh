#! /bin/bash/

helper="Harmonyz"
versnum="1.1"


	zenity --info --title="$helper $versnum" \
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
	"" "Strawberry" "Local (Install for Tidal)")


	HAM=$(echo $harmony | grep -c "Apple Music")
	if [ $HAM -gt '0' ]; then
 	sudo apt-get install snap snapd -yy
	sudo snap install apple-music-for-linux
	fi

	HAU=$(echo $harmony | grep -c "Audacious")
	if [ $HAU -gt '0' ]; then
	flatpak install flathub org.atheme.audacious -yy
	fi

	AUDIUS=$(echo $harmony | grep -c "Audius")
	if [ $AUDIUS -gt '0' ]; then
	wget "https://download.audius.co/Audius%200.16.6.AppImage" -O ./Audius.AppImage
        ./Audius.AppImage
	fi

	HBY=$(echo $harmony | grep -c "Byte")
	if [ $HBY -gt '0' ]; then
	flatpak install flathub com.github.alainm23.byte -yy
	fi

	HDE=$(echo $harmony | grep -c "Deezer")
	if [ $HDE -gt '0' ]; then
	sudo apt-get install flatpak -yy
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --if-not-exists nuvola https://dl.tiliado.eu/flatpak/nuvola.flatpakrepo
	flatpak update yy
	flatpak install nuvola eu.tiliado.NuvolaAppDeezer -yy && flatpak run eu.tiliado.NuvolaAppDeezer -yy
	flatpak run eu.tiliado.NuvolaAppDeezer
	fi

	HCM=$(echo $harmony | grep -c "CMUS")
	if [ $HCM -gt '0' ]; then
	sudo apt-get install libao-ocaml-dev cmus -yy
	fi

	HGN=$(echo $harmony | grep -c "Gnome Music Player")
	if [ $HGN -gt '0' ]; then
	flatpak install flathub org.gnome.Music -yy
	fi

	HH=$(echo $harmony | grep -c "Hydrogen")
	if [ $HH -gt '0' ]; then
	flatpak install org.hydrogenmusic.Hydrogen -yy
	fi

	HLY=$(echo $harmony | grep -c "Lyrics")
	if [ $HLY -gt '0' ]; then
	flatpak install flathub com.github.naaando.lyrics -yy
	fi

	HSP=$(echo $harmony | grep -c "Spotify")
	if [ $HSP -gt '0' ]; then
	flatpak install flathub com.spotify.Client -yy
	fi

	HST=$(echo $harmony | grep -c "Strawberry")
	if [ $HST -gt '0' ]; then
	sudo add-apt-repository ppa:jonaski/strawberry
	sudo apt-get update
	sudo apt-get install strawberry -yy
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



#Finish

	zenity --question --title="$helper $versnum: Finished" \
	--width=500 \
	--text="Thank you for using Harmonyz, you can support the development of this software and similar projects by donating BAT via our github page. Would you like to visit the ELCI-Linux github profile?"
		if [ $? -eq '0' ]; then
		xdg-open https://github.com/ELCI-Linux
		fi


