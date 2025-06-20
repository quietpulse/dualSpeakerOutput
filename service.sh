#!/system/bin/sh
# Dual speaker + watchdog for Poco C65 (MTK)

LOG=/data/local/tmp/dual_spkr.log
echo "Starting dual speaker config @ $(date)" > "$LOG"

chmod 755 /vendor/bin/tinymix
sleep 20

apply_settings() {
  /vendor/bin/tinymix 'Ext_Speaker_Amp Switch' 1
  /vendor/bin/tinymix 'FSM_AMP_MODE' 'MODE_SPK1'
  /vendor/bin/tinymix 'FSM_AMP_SWITCH' 1
  /vendor/bin/tinymix 'RCV Mux' 'Voice Playback'
  /vendor/bin/tinymix 'Handset_PGA_GAIN' '8Db'
  /vendor/bin/tinymix 159 5   # Audio_PGA1 → 30dB
  /vendor/bin/tinymix 160 5   # Audio_PGA2 → 30dB
}

# initial apply
apply_settings >> "$LOG" 2>&1
echo "Initial dual speaker applied @ $(date)" >> "$LOG"

# start a background watchdog loop
(
  echo "Watchdog loop started @ $(date)" >> "$LOG"
  while true; do
    apply_settings >> "$LOG" 2>&1
    sleep 30
  done
) &

echo "Service.sh done @ $(date)" >> "$LOG"
