# YT Player
[heading__title]:
  #yt-player
  "&#x2B06; Top of this page"


[`yt-player.sh`][yt_player__master__source_code] a wrapper script for `youtube-dl` and `omxplayer`


> The following covers how to install this branch within a user account


## [![Byte size of yt-player.sh][badge__master__yt_player__source_code]][yt_player__master__source_code] [![Open Issues][badge__issues__yt_player]][issues__yt_player] [![Open Pull Requests][badge__pull_requests__yt_player]][pull_requests__yt_player] [![Latest commits][badge__commits__yt_player__master]][commits__yt_player__master]



------


#### Table of Contents


- [&#x2B06; Top of ReadMe File][heading__title]

- [:zap: Quick Start][heading__quick_start]

- [:scroll: yt-player.sh Arguments][heading__api]

- [&#x1F5D2; Notes][notes]

- [:copyright: License][heading__license]


------


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; ...well as quick as it may get with things like this"


**Install Dependencies**


```Bash
sudo pip install --upgrade youtube-dl
```


**Git Commands**


1. Make a directory for Git sources

2. Change current directory to sub-directory path

3. Clone the source and any submodule dependencies


```Bash
mkdir -vp "${HOME}/git/hub/rpi-curious"

cd "${HOME}/git/hub/rpi-curious"

git clone --recurse-submodules git@github.com:rpi-curious/yt-player.git
```


**Install Commands**


1. Link `yt-player.sh` to a `PATH` accessible location

2. Set ownership and executable permissions


```Bash
mkdir ~/bin
ln -s "${HOME}/git/hub/rpi-curious/yt-player/yt-player.sh" "${HOME}/bin/"

chown ${USER}:${GROUPS} ~/bin/yt-player.sh
chmod u+x "${HOME}/git/hub/rpi-curious/yt-player/yt-player.sh"
```


**Update**


1. Change directory to repository root

2. Pull changes to source code

3. Update submodules utilized by this repository


```Bash
cd "${HOME}/git/hub/rpi-curious/yt-player"

git pull

git submodule update --init --recursive --merge
```

___


## YT Player API
[heading__api]:
  #yt-player-api
  "&#x1F4DC; The incantations that yt-player.sh script understands"


| Arguments | Type | Description |
|---|---|---|
| `both`  `hdmi`  `local`  `alsa` | boolean | Set audio output for `omxplayer` |
| `10`  `-10`                     | number  | Set volume in millibels for `omxplayer` |
| `http*`                         | string  | space separated list of URLs for `youtube-dl` to parse |


**Example**


```Bash
yt-player.sh hdmi 10\
 'https://www.youtube.com/playlist?list=PL45KLPZcC-zM_G2wTBt6NH-oqXUYt3ns7'\
 'https://www.youtube.com/watch?v=jxf8NBA3STc'\
 'https://www.youtube.com/watch?v=nuNVRKBkfXI'
```


___


## Notes
[notes]:
  #notes
  "&#x1F5D2; Additional notes and links that may be worth clicking in the future"


Silent pauses are to be expected for playlists, this is likely because of parsing `youtube-dl` output via Bash (receives entire list), where as Python generators might shorten wait times; but that is speculation.


Live streams do not work as of last test, however, one may consider `streamlink`...


```Bash
sudo pip install --upgrade streamlink
```


... for such needs, check [`reddit`](https://www.reddit.com/r/raspberry_pi/comments/8jfl5n/how_do_i_play_a_youtube_live_stream_full_screen/) discussion for `omxplayer` specific settings.


___


## License
[heading__license]:
  #license
  "&#x00A9; Legal bits of Open Source software"


```
YT Player quick start documentation
Copyright (C) 2019  S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation; version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```



[badge__commits__yt_player__master]:
  https://img.shields.io/github/last-commit/rpi-curious/yt-player/master.svg

[commits__yt_player__master]:
  https://github.com/rpi-curious/yt-player/commits/master
  "&#x1F4DD; History of changes on this branch"


[yt_player__community]:
  https://github.com/rpi-curious/yt-player/community
  "&#x1F331; Dedicated to functioning code"


[badge__issues__yt_player]:
  https://img.shields.io/github/issues/rpi-curious/yt-player.svg

[issues__yt_player]:
  https://github.com/rpi-curious/yt-player/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."


[badge__pull_requests__yt_player]:
  https://img.shields.io/github/issues-pr/rpi-curious/yt-player.svg

[pull_requests__yt_player]:
  https://github.com/rpi-curious/yt-player/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"


[badge__master__yt_player__source_code]:
  https://img.shields.io/github/languages/code-size/rpi-curious/yt-player

[yt_player__master__source_code]:
  https://github.com/rpi-curious/yt-player/blob/master/yt-player.sh
  "&#x2328; Project source code!"
