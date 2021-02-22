#!/bin/bash
cpuuse=$(cat /proc/loadavg | awk '{print $1}')

if [ "$cpuuse" > 80 ]; then


MESSAGE="/tmp/Mail"$(date +"%Y_%m_%d_%I_%M_%p")".out"


  echo "CPU Current Usage is: $cpuuse%" >> $MESSAGE

  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Top CPU Process Using top command" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "$(top -bn1 | head -20)" >> $MESSAGE

  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Top CPU Process Using ps command" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "$(ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10)" >> $MESSAGE


  fi


  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Disk usages" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "$(df -TH)" >> $MESSAGE




  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Disk usage more than 60%" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "" >> $MESSAGE

  df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }' | while read output;
  do

   used=$(echo $output | awk '{print $1}' | sed s/%//g)
   partition=$(echo $output | awk '{print $2}')
   if [ $used -ge 60 ]; then
   echo "The partition \"$partition\" on $(hostname) has used $used% at $(date)" >> $MESSAGE
   fi
  done

  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Top 10 Network usage " >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "" >> $MESSAGE

  echo " $(vnstat -t)" >> $MESSAGE

  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Weekly Network usage " >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "" >> $MESSAGE

  echo " $(vnstat)" >> $MESSAGE

  echo "" >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "Network Traffic " >> $MESSAGE

  echo "+------------------------------------------------------------------+" >> $MESSAGE

  echo "" >> $MESSAGE

  echo " $(vnstat -tr)" >> $MESSAGE

  echo "" >> $MESSAGE

