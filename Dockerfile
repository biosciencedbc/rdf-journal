FROM ruby

WORKDIR /

RUN mkdir /data && mkdir /work

ADD ./ /

ENTRYPOINT [ "/convert_nlm_catalog" ]


