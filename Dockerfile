FROM ruby

WORKDIR /

RUN mkdir /data && mkdir /test

ADD ./ /

CMD bash convert_pubmed_journal


