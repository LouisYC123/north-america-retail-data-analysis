
import pandas as pd
import os
from pathlib import Path
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

POSTGRES_USER=os.getenv('POSTGRES_USER')
POSTGRES_PASSWORD=os.getenv('POSTGRES_PASSWORD')
POSTGRES_DB='retail' # Do not change
POSTGRES_SCHEMA='retail' # Do not change

# Create postgres connection engine
engine = create_engine(f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@postgres_container:5432/{POSTGRES_DB}")

# Extract
print('reading data from www.census.gov')
data = pd.read_excel(
    'https://www.census.gov/retail/mrts/www/mrtssales92-present.xlsx', 
    sheet_name=None,
    header=4
    )

# Load
print('loading data to postgres')
for sheetname, df in data.items():
    if sheetname != '2023':
        df.to_sql(
            f'raw_{sheetname}_data', engine, index=False, if_exists="replace", schema=POSTGRES_SCHEMA
        )

print('load complete')
