FROM python:3

RUN mkdir -p /my_project
WORKDIR /my_project
COPY . .
RUN pip3 install -r requirements.txt

CMD [ "python3", "./api.py"]