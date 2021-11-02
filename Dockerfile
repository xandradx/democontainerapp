FROM python:slim as BUILDER
MAINTAINER Jorge Andrade <jandrade@i-t-m.com>
RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ADD ./requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

FROM python:slim as APP
COPY --from=BUILDER /opt/venv /opt/venv
RUN useradd --uid 1000 -g 0 app
ENV PATH="/opt/venv/bin:$PATH"
ADD . /home/app/
WORKDIR /home/app
USER app
EXPOSE 8080
CMD ["python", "app.py"]
