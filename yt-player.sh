#!/bin/bash


## Find true directory this script resides in
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__NAME__="${__SOURCE__##*/}"

__AUTHOR__='S0AndS0'
__DESCRIPTION__="A wrapper script for 'youtube-dl' and 'omxplayer'"


source "${__DIR__}/modules/trap-failure/failure.sh"
trap 'failure "LINENO" "BASH_LINENO" "${BASH_COMMAND}" "${?}"' ERR


#
# Functions
#
__license__(){
    cat <<EOF
${__DESCRIPTION__}
Copyright (C) 2019 ${__AUTHOR__}

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
EOF
}


usage(){
    cat <<EOF
${__DESCRIPTION__}
Copyright AGPL-3.0 2019 ${__AUTHOR__}


    ${0##*/} 1500 both <link> <link> ...


Volume &/or output are not required and script will use following defaults


    _VOL -> ${_VOL}   Set initial volume in millibels (default 0)
    _OUT -> ${_OUT}   Audio out device, eg. hdmi | local | both | alsa[:device]


URLs/links should be a space separated list of quoted links, eg


    yt-player.sh hdmi 10\
     'https://www.youtube.com/playlist?list=PL45KLPZcC-zM_G2wTBt6NH-oqXUYt3ns7'\
     'https://www.youtube.com/watch?v=jxf8NBA3STc'\
     'https://www.youtube.com/watch?v=nuNVRKBkfXI'


Additional arguments


--help  |  help  | -h
> Prints this message and exits


--license  |  license
> Prints license for ${__NAME__} and exits
EOF
}


get_links(){
    youtube-dl --ignore-errors\
               --get-url\
               --youtube-skip-dash-manifest\
               --format best\
               "${1:?No link provided}"
}


play_link(){
    omxplayer --blank\
              --adev ${_OUT}\
              --vol ${_VOL}\
              "${1:?No media source provided}"
}


play_url(){
    _url="${1:?No URL provided}"
    for _link in $(get_links "${_url}"); do
        if [ -z "${_link}" ]; then continue; fi
        play_link "${_link}"
    done
    return ${_exit_code:-0}
}


#
# Do the things
#


## Default variables
_VOL='0'
_OUT='both'


## Parse arguments
_URLS=()
_ARGS=("${@}")
for _arg in "${_ARGS[@]}"; do
    _sarg="${_arg//[^[:print:]]/}"
    case "${_sarg}" in
        '--license'|'license')
            __license__
            exit 0
        ;;
        '--help'|'help'|'-h')
            usage
            exit 0
        ;;
        'http'*)
            _URLS+=("${_sarg}")
        ;;
        'both'|'hdmi'|'local'|'alsa'*)
            _OUT="${_sarg}"
        ;;
        [0-9]*|-[0-9]*)
            _t="${_sarg//[^-0-9]/}"
            _VOL="${_t:0:5}"
        ;;
        *)
            usage
            exit 1
        ;;
    esac
done


if [[ "${#_ARGS[@]}" == '0' ]] || [[ "${#_URLS[@]}" == '0' ]]; then
    usage
    exit 1
fi


## Loop over URLs provided
for _url in "${_URLS[@]}"; do
    play_url "${_url}"
    _exit_code="${?:-0}"

    if [ "${_exit_code}" -gt '0' ]; then
        printf '# Exit code: %i' "${_exit_code}"
        break
    fi
done
