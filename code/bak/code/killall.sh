#!/bin/bash

ps -ef | grep ConfClient.exe | grep -v grep | awk '{print $2}' | xargs kill