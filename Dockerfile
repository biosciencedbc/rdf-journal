FROM ruby

WORKDIR /

RUN mkdir /data && mkdir /work

ADD ./ /

CMD bash convert_nlm_catalog


