FROM hashicorp/packer:latest
#FROM hashicorp/packer:1.8.0 #1.8.0 works as of 2024-08-19

LABEL "repository" = "https://github.com/ExitoLab/packer-build-action"
LABEL "homepage" = "https://github.com/ExitoLab/packer-build-action"
LABEL "maintainer" = "Ige Adetokunbo Temitayo <igeadetokunbo@gmail.com>"

LABEL "com.github.actions.name" = "Packer build on AWS"
LABEL "com.github.actions.description" = "Run packer build on a template file on AWS"
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
