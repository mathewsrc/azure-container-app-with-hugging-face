FROM python:3.8

COPY ./requirements.txt /webapp/requirements.txt

WORKDIR /webapp

RUN pip install -r requirements.txt

COPY webapp/* /webapp

EXPOSE 8000

# Creates a non-root user with an explicit UID and adds permission to access the /webapp folder
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /webapp
USER appuser

ENTRYPOINT [ "uvicorn" ]

CMD [ "--host", "0.0.0.0", "main:app" ]
