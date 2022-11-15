FROM andymeneely/squib:latest
WORKDIR /usr/src/app

# RUN mkdir ~/.fonts
# COPY fonts/*.otf /usr/share/fonts/
# COPY fonts/*.ttf /usr/share/fonts/
# RUN fc-cache -f -v /usr/share/fonts/
COPY Gemfile /usr/src/app

RUN bundle install

