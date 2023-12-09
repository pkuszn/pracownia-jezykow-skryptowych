# Description

Rasa based chabot used to handle restaurant orders.

# Usage

Activate virtual env
``` powershell
.\venv\Scripts\activate
```

Run ngrok
```powershell
ngrok http 5005
```

Copy url to ./credentials.yml as below
```yml
webhook_url: "https://633c-217-96-202-162.ngrok.io/webhooks/telegram/webhook"
```

Run rasa
``` powershell
python -m rasa run
```

Open telegram and start writing messages.

# Training

To train your intentions use
```powershell
python -m rasa train
```

# Use custom actions endpoints

To use custom actions run below command to start custom actions server
```powershell
python -m rasa run actions --endpoints endpoints.yml
```

# Requirements

- W10
- Python 3.10
