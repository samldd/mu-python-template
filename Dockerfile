FROM python:2.7
MAINTAINER Sam Landuydt "sam.landuydt@gmail.com"

ENV APP_ENTRYPOINT web
ENV LOG_LEVEL info
ENV MU_SPARQL_ENDPOINT 'http://database:8890/sparql'
ENV MU_SPARQL_UPDATEPOINT 'http://database:8890/sparql'
ENV MU_APPLICATION_GRAPH 'http://mu.semte.ch/application'

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app

RUN ln -s /app /usr/src/app/ext \
     && cd /usr/src/app \
     && pip install -r requirements.txt

ONBUILD ADD . /app/
ONBUILD RUN cd /app/ \
    && pip install -r requirements.txt

EXPOSE 80

CMD ["touch" "touch /usr/src/app/ext/app/__init__.py"]
CMD python web.py