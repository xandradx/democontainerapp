FROM python:slim as BUILDER
RUN apt-get update && apt-get install -y --no-install-recommends gcc  python3-dev  && \
    pip install --upgrade pip && \
    python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

FROM python:slim as APP
LABEL MAINTAINER Jorge Andrade <jandrade@i-t-m.com>
COPY --from=BUILDER /opt/venv /opt/venv
RUN useradd --uid 1000 -g 0 app
ENV PATH="/opt/venv/bin:$PATH"
COPY . /home/app/
WORKDIR /home/app
USER app
EXPOSE 8080
CMD ["python", "app.py"]
