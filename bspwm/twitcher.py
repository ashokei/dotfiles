#!/usr/bin/env python
#-------------------------------------------------
# file: twitcher.py
# author: Florian Ehmke
# description: dmenu for twitch streams
#-------------------------------------------------
import argparse
import requests
import subprocess
from subprocess import Popen, PIPE, STDOUT

class Stream(object):
    def __init__(self, name, status, viewers):
        self.name = name
        self.status = status
        self.viewers = viewers

    def display_string(self):
        display_string = u"{} ({}) - {}\n".format(self.name, self.viewers, self.status).strip()
        return display_string + "\n"

def create_arg_parser():
    parser = argparse.ArgumentParser(description='Open twitch stream through dmenu.')
    parser.add_argument(
        '-c', '--count', required=False, default=25, type=int,
        help='How many (default: 25) streams should be displayed?')
    parser.add_argument(
        '-g', '--game', required=False, default="StarCraft II%3A Heart of the Swarm", type=str,
        help='Which game (default: Starcraft II: Heart of the Swarm)?')
    parser.add_argument(
        '-q', '--quality', required=False, default="best", type=str,
        help='Which quality (default: best)?')
    parser.add_argument(
        '-p', '--player', required=False, default="mpv", type=str,
        help='Which player (default: mpv)?')
    return vars(parser.parse_args());

def main():
    args = create_arg_parser()

    count = args['count']
    game = args['game']
    quality = args['quality']
    player = args['player']

    dmenu_command = ['dmenu', '-l', str(count),
        '-nb', '#2D2D2D', '-nf', '#899CA1',
        '-sb', '#2D2D2D', '-sf', '#C0C0C0',
        '-fn', "-*-terminus-medium-*-*-*-16-*-*-*-*-*-*-*"]

    url = "https://api.twitch.tv/kraken/streams?limit=100&game=" \
          "{}&limit={}".format(game.replace(' ','+'), count)

    r = requests.get(url)
    json_streams = r.json()["streams"]
    streams = []
    for json_stream in json_streams:
        channel = json_stream["channel"]
        name = channel["name"]
        status = channel["status"]
        viewers = json_stream["viewers"]
        streams.append(Stream(name, status, viewers))

    dmenu_str = ""
    for stream in streams:
        dmenu_str += stream.display_string()
    dmenu_str.strip()

    p = Popen(dmenu_command, stdout=PIPE, stdin=PIPE, stderr=STDOUT)
    stream_selection = p.communicate(input=dmenu_str.encode('utf-8'))[0]
    if stream_selection:
        streamer = stream_selection.decode('utf-8').split()[0]
        url = "twitch.tv/{}".format(streamer)
        cmd=["livestreamer",url,quality,"-p",player]
        print("{} {} {} {}".format(cmd[1],cmd[2],cmd[3],cmd[4]))

if __name__ == "__main__":
    main()
