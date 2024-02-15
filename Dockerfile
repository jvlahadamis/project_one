# Use the shiny-verse as a base image
FROM --platform=linux/amd64 rocker/shiny-verse:latest

# Install dependencies
RUN apt-get update && apt-get install -y git \
    libssl-dev \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libcurl4-doc \
    libgnutls28-dev \
    libidn11-dev \
    libkrb5-dev \
    libldap2-dev \
    librtmp-dev \
    libssh2-1-dev \
    icu-doc libssl-doc


# Install/clone the files from the from GitHub repository
RUN git clone https://github.com/jvlahadamis/project_one.git /srv/shiny-server/project_one

# Install R packages contained in the requirements file
RUN Rscript /srv/shiny-server/project_one/requirements.R

# Make the Shiny app available at port 3838
EXPOSE 3838

# Run the app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/project_one/', host = '0.0.0.0', port = 3838)"]