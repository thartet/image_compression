# Image compression script 
This script is used to reduce the image size and optimize the number of colors of the image.
## Installation guide
You first have to clone the repository to obtain the script locally.
To run the script you need to install two libraries : *pngquant* and *ImageMagick*. <br><br>
### Install pngquant : <br>
Update the package list : 
```bash
sudo apt update
```
Run the command to install the library : 
```bash
# Debian based
sudo apt install -y pngquant

# Arch based
sudo pacman -S pngquant
```
You can check the version to verify that the library was installed : 
```bash
pngquant --version
```
### Install ImageMagick
It is highly possible that *ImageMagick* is already installed on your computer, since many softwares use it as a dependency. You can verify the installation with the following command line :
```bash
convert -version
```
Run the command to install the software :
```bash
# Debian based
sudo apt install -y imagemagick

# Arch based
sudo pacman -S imagemagick
```
You can check the version to verify that the library was installed : 
```bash
convert -version
```

## How to run
Then you can run the script with the images that you want to compress. <br>

```bash
./compress.sh <file>
```

## Usage with docker
```bash
docker build -t image_compress
docker run -it --rm -v /path/to/image/folder:/data image_compress
```

Then you can run the script
```bash
compress.sh /data/<file>
```

***You can only use this script to compress png, jpeg and webp files !***

## To do
- [x] Reduction of the number of colors of the image.
- [x] Implementation of different treatments for png, jpeg and webp files.
- [x] Reduction of the quality of the image.
- [x] Usage with -h option
- [x] Add a Dockerfile
- [ ] Modify the script so that it could be implemented as a plugin on a web site.
- [ ] Gestion of the codes returned by the script.
- [ ] Adaptative compression (low, medium and high mode)