FROM ghcr.io/open-webui/open-webui:main

# Override the start script to use port 10000
RUN echo '#!/bin/bash\ncd /app/backend\nuvicorn open_webui.main:app --host 0.0.0.0 --port 10000' > /app/backend/start.sh && \
    chmod +x /app/backend/start.sh
