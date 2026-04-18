#!/usr/bin/env python3

import json
import calendar
import re
from datetime import datetime

now = datetime.now()
today = now.day

# Bar 显示
text = now.strftime("%d")
alt = now.strftime("%Y-%m-%d")

# 生成月历
cal = calendar.TextCalendar(firstweekday=0)
cal_output = cal.formatmonth(now.year, now.month)

# --- 高亮逻辑 ---
# 使用正则表达式匹配独立的数字，确保只匹配“今天”
# \b 表示单词边界，防止把 25 里的 5 给高亮了
pattern = rf"\b{today}\b"

# 使用 Pango 标签高亮：这里用加粗 <b> 和 橙色颜色 <span color='#ffb86c'>
# 你可以根据你的配色方案修改 color 的十六进制值
replacement = f"<b><u><span color='#ffb86c'>{today}</span></u></b>"
highlighted_cal = re.sub(pattern, replacement, cal_output)

# 强制等宽字体包裹
tooltip = f"<tt><small>{highlighted_cal}</small></tt>"

print(json.dumps({
    "text": text,
    "alt": alt,
    "tooltip": tooltip
}, ensure_ascii=False))
