# 🐙 KRAKEN — AI Screenshot Assistant

KRAKEN is a lightweight Windows automation tool that detects newly created screenshots, analyzes them with an AI vision model, and sends concise results directly to Telegram.

It runs silently in the background and can be enabled or disabled instantly with a global keyboard shortcut.

---

## ✨ Features

- 📸 Automatically detects new Windows screenshots
- 🤖 Analyzes screenshots using OpenAI vision capabilities
- 📩 Sends results directly to Telegram
- ⌨️ Global `CTRL + ALT + K` ON/OFF hotkey
- 🔴 Starts in OFF mode by default
- 🖥️ Runs in the Windows background
- 🚫 Prevents multiple Kraken instances from running simultaneously
- 🗑️ Moves session screenshots to the Windows Recycle Bin after the session ends
- 🔐 Keeps API keys and Telegram credentials outside the source code
- ♻️ Avoids automatic OpenAI SDK retries to reduce accidental duplicate requests
- ⚙️ Includes an optional Windows Task Scheduler installer

---

## 🧠 How It Works

```text
Windows Screenshot
        ↓
KRAKEN detects the new image
        ↓
Screenshot is moved to a temporary Kraken folder
        ↓
OpenAI analyzes the image
        ↓
Result is sent to Telegram
        ↓
User presses CTRL + ALT + K
        ↓
KRAKEN turns OFF
        ↓
Session screenshots are moved to Recycle Bin