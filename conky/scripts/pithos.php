#!/usr/bin/php
<?php

$song=`dbus-send --print-reply --dest=net.kevinmehall.Pithos /net/kevinmehall/Pithos net.kevinmehall.Pithos.GetCurrentSong`;

$matches = array();

switch($argv[1]) {
    case 'album':
        $pattern = '~"album".*?"(.*?)".*~s';
        break;
    case 'title':
        $pattern = '~"title".*?"(.*?)".*~s';
        break;
    case 'artist':
        $pattern = '~"artist".*?"(.*?)".*~s';
        break;
    default:
        exit;
}

preg_match($pattern, $song, $matches);

if($matches) {
    echo $matches[1];
}
?>
