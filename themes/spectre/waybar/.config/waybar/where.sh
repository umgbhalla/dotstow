#!/usr/bin/env bash
tail -1 $HOME/ristate.log | jq '.["tags"][].ChimeiInnoluxCorporation[]|tonumber'
