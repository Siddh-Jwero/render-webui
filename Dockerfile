FROM ghcr.io/open-webui/open-webui:main

WORKDIR /app/backend

RUN mkdir -p /app/backend/static
RUN mkdir -p /app/backend/data
RUN mkdir -p /app/cache

# Install necessary dependencies
RUN apt-get update && apt-get install -y apache2-utils sqlite3

# Update the password in webui.db
# COPY webui.db /webui.db
# RUN --mount=type=secret,id=ORIN_PASSWORD,mode=0444,required=true \
#     htpasswd -bnBC 10 "" "$(cat /run/secrets/ORIN_PASSWORD)" | tr -d ':\n' > /tmp/password_hash && \
#     sqlite3 /webui.db "UPDATE auth SET password='$(cat /tmp/password_hash)' WHERE email='vilarin@huggingface.co';" && \
#     rm /tmp/password_hash

# Copy the updated webui.db to the desired location
# RUN cp /webui.db /app/backend/data/webui.db
COPY webui.db /app/backend/data/webui.db
COPY env.py /app/backend/open_webui/env.py

RUN chmod -R 777 /app/backend/static
RUN chmod -R 777 /app/backend/data
RUN chmod -R 777 /app/cache

CMD ["sh", "-c", "uvicorn open_webui.main:app --host 0.0.0.0 --port ${PORT}"]
