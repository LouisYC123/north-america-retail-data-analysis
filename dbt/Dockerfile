FROM python:3.10

RUN apt-get update \
    && apt-get install -y --no-install-recommends

# WORKDIR /usr/src/dbt/dbt_project

# Install the dbt Postgres adapter. This step will also install dbt-core
COPY . /home
RUN pip install --upgrade pip
RUN pip install -r /home/requirements.txt
WORKDIR /home/dbt_project


# Install dbt dependencies (as specified in packages.yml file)
# Build seeds, models and snapshots (and run tests wherever applicable)
CMD dbt deps && dbt build --profiles-dir profiles && sleep infinity