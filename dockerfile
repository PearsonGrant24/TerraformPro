# terraform-awscli/Dockerfile
FROM hashicorp/terraform:1.7.5

# Install AWS CLI v2
RUN apk add --no-cache curl unzip bash \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

# Verify installs
RUN terraform -version && aws --version
