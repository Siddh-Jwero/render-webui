FROM ghcr.io/open-webui/open-webui:main
ENTRYPOINT ["uvicorn", "open_webui.main:app", "--host", "0.0.0.0", "--port", "10000"]
