import pandas as pd
import subprocess

def view(df):
    subprocess.run(['vd', '-f', 'csv'], input=df.to_csv(index=False), text=True)

