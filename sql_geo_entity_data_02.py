import sqlite3
import csv

target_columns_dict  = {
   'Entity code':'geo_entity_code',
   'Entity name':'geo_entity_name',
   'Entity abbreviation':'geo_entity_abbreviation',
   'Entity theme':'geo_entity_theme',
   'Entity coverage':'geo_entity_coverage',
   'Status':'geo_entity_status',
   'Entity owner abbreviation':'geo_entity_owner_abbreviation',
}

data = []

with open("data.csv", mode="r", encoding="utf-8") as file:
   csv_reader = csv.DictReader(file)
   # Each row is a dictionary in the list
   data = []
   for row in csv_reader:
      new_row = {}
      for csv_name, db_name in target_columns_dict.items():
         val = row.get(csv_name)
         if val is not None and val.strip():
            new_row[db_name] = val.strip().lower()
         else:
            new_row[db_name] = None
      data.append(new_row)


sql = """
INSERT INTO geo_entity_types (
   geo_entity_code,
   geo_entity_name,
   geo_entity_abbreviation,
   geo_entity_theme,
   geo_entity_coverage,
   geo_entity_status,
   geo_entity_owner_abbreviation
) VALUES (
   :geo_entity_code,
   :geo_entity_name,
   :geo_entity_abbreviation,
   :geo_entity_theme,
   :geo_entity_coverage,
   :geo_entity_status,
   :geo_entity_owner_abbreviation
);
"""

conn = sqlite3.connect("ons_geography.db")
cursor = conn.cursor()

cursor.execute("PRAGMA foreign_keys = ON")
cursor.execute("PRAGMA double_quoted_string_literals = OFF")

success_count = 0
for index, row in enumerate(data, start=1):
    try:
        cursor.execute(sql, row)
        success_count += 1
    except sqlite3.Error as e:
        print(f"\nFailed on row {index}: {e}")
        print("Row content causing failure:")
        for k, v in row.items():
            print(f"  {k}: '{v}'")
        break 
conn.commit()
conn.close()
