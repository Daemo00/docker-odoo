FROM ubuntu:18.04

# WARNING ? py.warnings: /usr/local/lib/python3.6/dist-packages/werkzeug/filesystem.py:63: BrokenFilesystemWarning: Detected a misconfigured UNIX filesystem: Will use UTF-8 as filesystem encoding instead of 'ascii' BrokenFilesystemWarning)
ENV LANG C.UTF-8

# Install Odoo
RUN apt-get update

RUN apt-get install -y git

RUN git clone https://github.com/odoo/odoo.git --branch=12.0 --depth=1

RUN apt-get install -y python3-dev

RUN apt-get install -y python3-pip

# fatal error: libxml/xpath.h: No such file or directory
RUN apt-get install -y libxml2-dev libxslt1-dev

# fatal error: lber.h: No such file or directory
RUN apt-get install -y libldap2-dev

# fatal error: sasl.h: No such file or directory
RUN apt-get install -y libsasl2-dev

RUN pip3 install -r odoo/requirements.txt

# Install postgresql client
RUN apt-get install -y postgresql-client

# Expose Odoo services
EXPOSE 8069 8071

COPY ./.odoorc /root/

CMD odoo/odoo-bin
