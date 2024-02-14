


FROM --platform=linux/amd64 rocker/shiny-verse:latest
RUN apt-get update && apt-get install -y git


# Install from GitHub repository
RUN git clone https://github.com/jvlahadamis/project_one.git /srv/shiny-server/project_one


# Make the Shiny app available at port 3838
EXPOSE 3838

# Run the app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/shiny-stocks/', host = '0.0.0.0', port = 3838)"]
