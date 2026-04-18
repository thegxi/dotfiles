#!/usr/bin/env python3

import json
from datetime import datetime
from zoneinfo import ZoneInfo

CITIES = [
    ("🇨🇳", "China", "Asia/Shanghai"),
    ("🇬🇧", "London", "Europe/London"),
    ("🇮🇷", "Tehran", "Asia/Tehran"),
    ("🇦🇺", "Sydney", "Australia/Sydney"),
    ("🇨🇦", "Toronto", "America/Toronto"),
    ("🇺🇸", "New York", "America/New_York"),
    ("🇺🇸", "Los Angeles", "America/Los_Angeles"),
    ("🇯🇵", "Tokyo", "Asia/Tokyo"),
]

def now(tz):
    return datetime.now(ZoneInfo(tz))

def safe_multiline(s: str):
    # Waybar/GTK 更稳定：避免 raw newline
    return s.replace("\n", "\\n")

bar_time = now("Asia/Shanghai").strftime(" %m-%d  %H:%M")
date_line = now("Asia/Shanghai").strftime("%A %d %B %Y")

city_lines = "\n".join(
    f"{flag} {city:<10} {now(tz).strftime('%H:%M')}"
    for flag, city, tz in CITIES
)

tooltip_raw = f"{date_line}\n\n{city_lines}"

print(json.dumps({
    "text": bar_time,
    "tooltip": tooltip_raw,
    "class": "clock"
}, ensure_ascii=False))
