FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y -qq --no-install-recommends apt-cacher

# allow access from everywhere
RUN echo "allowed_hosts = *" >> /etc/apt-cacher/apt-cacher.conf

# enable multi-distro support (debian and ubuntu alike)
RUN echo "distinct_namespaces = 1" >> /etc/apt-cacher/apt-cacher.conf

# extend ubuntu release names (and keep adding future versions...)
ENV UBUNTU_RELEASE_NAMES dapper, edgy, feisty, gutsy, hardy, intrepid, jaunty, karmic, lucid, maverick, natty, oneiric, precise, quantal, trusty, utopic, vivid

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
EXPOSE 3142

