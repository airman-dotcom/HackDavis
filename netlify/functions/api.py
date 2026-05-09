from fastapi import FastAPI
from mangum import Mangum
from main import app  # Import your FastAPI instance

handler = Mangum(app)