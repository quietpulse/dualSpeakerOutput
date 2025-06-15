#!/system/bin/sh
# Dual speaker setup for Poco C65 (MTK)

LOG=/data/local/tmp/dual_spkr.log
echo "Starting dual speaker config at $(date)" > "$LOG"

chmod 755 /vendor/bin/tinymix
echo "Set tinymix executable at $(date)" >> "$LOG"

sleep 20

# Enable dual speakers
/vendor/bin/tinymix 'Ext_Speaker_Amp Switch' 1      >> "$LOG" 2>&1
/vendor/bin/tinymix 'FSM_AMP_MODE' 'MODE_SPK1'      >> "$LOG" 2>&1
/vendor/bin/tinymix 'FSM_AMP_SWITCH' 1              >> "$LOG" 2>&1
/vendor/bin/tinymix 'RCV Mux' 'Voice Playback'      >> "$LOG" 2>&1

# Earpiece gain
/vendor/bin/tinymix 'Handset_PGA_GAIN' '6Db'        >> "$LOG" 2>&1

# Bottom speaker gain — using index (159 = PGA1, 160 = PGA2)
/vendor/bin/tinymix 159 5                           >> "$LOG" 2>&1
/vendor/bin/tinymix 160 5                           >> "$LOG" 2>&1

echo "Finished dual speaker config at $(date)" >> "$LOG"
