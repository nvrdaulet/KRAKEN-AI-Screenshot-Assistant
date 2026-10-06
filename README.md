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

---

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/nvrdaulet/KRAKEN-AI-Screenshot-Assistant.git
cd KRAKEN-AI-Screenshot-Assistant
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Configure your credentials

Create your own `.env` file from the example:

```powershell
Copy-Item .env.example .env
```

Then open `.env` and replace the placeholders with your own credentials:

```env
OPENAI_API_KEY=your_openai_api_key_here
TELEGRAM_TOKEN=your_telegram_bot_token_here
TELEGRAM_CHAT_ID=your_telegram_chat_id_here
```

> ⚠️ Never commit, upload, or share your `.env` file.

### 4. Run manually

```bash
python watcher.py
```

KRAKEN starts in **OFF** mode.

Press:

```text
CTRL + ALT + K
```

to enable or disable it.

### 5. Optional background installation

To run KRAKEN automatically in the Windows background:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

---

## 🔐 Security

KRAKEN includes several safety measures:

- API keys and Telegram credentials are stored in `.env`
- `.env` is excluded from Git using `.gitignore`
- Only one KRAKEN instance can run at a time
- KRAKEN starts in OFF mode
- Automatic OpenAI SDK retries are disabled
- Raw API errors are not sent to Telegram
- Session screenshots are moved to the Windows Recycle Bin instead of being permanently deleted
- Background execution does not require administrator privileges

---

## 🔒 Privacy

When KRAKEN is enabled, screenshots are sent to the configured AI API for analysis.

The generated response is then sent to the configured Telegram chat.

Do not process screenshots containing:

- passwords
- API keys
- authentication codes
- confidential documents
- sensitive personal information

The user is responsible for deciding what content is processed.

---

## ⚠️ Responsible Use

KRAKEN is an educational and productivity automation project.

It is not intended to bypass proctoring systems, security controls, access restrictions, or academic integrity policies.

Users are responsible for following the rules of the websites, institutions, platforms, and services they use.

---

## 📄 License

This project is licensed under the GNU General Public License v3.0 (GPL-3.0).

See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

Created by **Nurdaulet**.

If you find KRAKEN useful or interesting, consider giving the repository a ⭐.